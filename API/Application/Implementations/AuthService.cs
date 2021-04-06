using Application.Interfaces;
using Application.RequestModels;
using Application.ViewModels;
using Data.Entities;
using Data.Enum;
using Data_EF;
using Data_EF.Repositories;
using JWT;
using JWT.Algorithms;
using JWT.Builder;
using JWT.Exceptions;
using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Utilities.Constants;
using Utilities.Helper;

namespace Application.Implementations
{
    public class AuthService : IAuthService
    {
        private readonly IHttpContextAccessor _httpContextAccessor;
        private IUnitOfWork _unitOfWork;
        private IUserRepository _userRepository;
        private ISystemRepository _systemRepository;
        private IAuthTokenRepository _authTokenRepository;
        private IEmailService _emailService;

        public AuthService(IUnitOfWork unitOfWork, IHttpContextAccessor httpContextAccessor, IEmailService emailService)
        {
            _httpContextAccessor = httpContextAccessor;
            _unitOfWork = unitOfWork;
            _userRepository = unitOfWork.User;
            _systemRepository = unitOfWork.System;
            _authTokenRepository = unitOfWork.AuthToken;
            _emailService = emailService;
        }

        public AuthUser User
        {
            get
            {
                return (AuthUser)_httpContextAccessor.HttpContext.Items["User"];
            }
        }

        public async Task<ApiResponse> Login(UserLoginModel model)
        {
            if (String.IsNullOrWhiteSpace(model.Username) || String.IsNullOrWhiteSpace(model.Password))
            {
                return ApiResponse.BadRequest();
            }

            var hashedPassword = PasswordHelper.Hash(model.Password);
            var user = _userRepository.FirstOrDefault(x => x.Username == model.Username && x.Password == hashedPassword);

            if (user == null)
            {
                return ApiResponse.NotFound();
            }

            if (!user.IsActivated)
            {
                return ApiResponse.NotFound(UserMessageConst.PleaseActiveUser);
            }

            if (user.Role != AppUserRole.ADMIN)
            {
                if (user.IsDeleted)
                {
                    return ApiResponse.NotFound(UserMessageConst.UserDeleted);
                }

                var system = _systemRepository.FirstOrDefault(x => x.Id == user.SystemId && !x.IsDeleted);
                if (system == null)
                {
                    return ApiResponse.NotFound(UserMessageConst.SystemDeleted);
                }
            }

            var accessToken = GenerateAccessToken(user.Id, user.Role);
            var refreshToken = GenerateRefreshToken();
            await SaveRefreshToken(user.Id, refreshToken);
            await _unitOfWork.SaveChanges();
            return ApiResponse.OK(new { _id = user.Id, accessToken, refreshToken, role = user.Role });
        }

        public AuthUser VerifyToken(string token)
        {
            AuthUser user = null;
            try
            {
                var payload = new JwtBuilder()
                                           .WithAlgorithm(new HMACSHA256Algorithm())
                                           .WithSecret(ConfigurationHelper.Configuration["JWT:Secret"])
                                           .MustVerifySignature()
                                           .Decode<IDictionary<string, string>>(token);
                if (payload.TryGetValue("_id", out string idValue) && payload.TryGetValue("role", out string roleValue) && payload.TryGetValue("exp", out string expValue))
                {
                    var role = int.Parse(roleValue);
                    user = new AuthUser
                    {
                        Id = Guid.Parse(idValue),
                        IsAdmin = role == AppUserRole.ADMIN,
                        IsEmployee = role == AppUserRole.EMPLOYEE,
                        IsLineManager = role == AppUserRole.LINE_MANAGER,
                        IsProjectManager = role == AppUserRole.PROJECT_MANAGER
                    };
                }
            }
            catch (Exception)
            {
                user = null;
            }

            return user;
        }

        public async Task<ApiResponse> GetAccessToken(GetAccessTokenModel model)
        {
            var user = _authTokenRepository.GetMany(x => x.UserId == model.UserId && x.RefreshToken == model.RefreshToken)
                .Join(_userRepository.GetMany(x => x.Id == model.UserId && x.IsActivated && !x.IsDeleted), x => x.UserId, y => y.Id,
                (x, y) => new { y.Id, y.Role, y.SystemId })
                .Join(_systemRepository.GetMany(x => !x.IsDeleted), x => x.SystemId, y => y.Id,
                (x, y) => new { x.Id, x.Role })
                .FirstOrDefault();

            if (user == null)
            {
                return ApiResponse.NotFound();
            }

            return ApiResponse.OK(GenerateAccessToken(user.Id, user.Role));
        }

        public async Task<ApiResponse> ChangePassword(ChangePasswordModel model)
        {
            if (!ValidateHelper.IsValidPassword(model.NewPassword))
            {
                return ApiResponse.BadRequest(UserMessageConst.InvalidPassword);
            }

            var oldPasswordHashed = PasswordHelper.Hash(model.OldPassword);
            var user = _userRepository.FirstOrDefault(x => x.Id == User.Id && x.Password == oldPasswordHashed);
            if (user == null)
            {
                return ApiResponse.NotFound();
            }

            user.Password = PasswordHelper.Hash(model.NewPassword);
            _userRepository.Update(user);

            var tokenRemove = _authTokenRepository.GetMany(x => x.UserId == User.Id);
            _authTokenRepository.RemoveRange(tokenRemove);

            await _unitOfWork.SaveChanges();

            return ApiResponse.OK();
        }

        private string GenerateAccessToken(Guid userId, int role)
        {
            var expiryMinuteValue = ConfigurationHelper.Configuration["JWT:ExpiryMinute"];
            var expiryMinute = int.Parse(expiryMinuteValue);

            return new JwtBuilder()
                 .WithAlgorithm(new HMACSHA256Algorithm())
                 .WithSecret(ConfigurationHelper.Configuration["JWT:Secret"])
                 .AddClaim("exp", DateTimeOffset.UtcNow.AddMinutes(expiryMinute).ToUnixTimeSeconds())
                 .AddClaim("_id", userId)
                 .AddClaim("role", role)
                 .Encode();
        }

        private string GenerateRefreshToken()
        {
            return GenerateHelper.RandomString(40);
        }

        private async Task SaveRefreshToken(Guid userId, string refreshToken)
        {
            _authTokenRepository.Add(new AuthToken { Id = Guid.NewGuid(), RefreshToken = refreshToken, UserId = userId });
        }

        public string GenerateChangePasswordToken(Guid userId)
        {
            var expiryMinuteValue = ConfigurationHelper.Configuration["JWT:ExpiryMinute"];
            var expiryMinute = int.Parse(expiryMinuteValue);

            return new JwtBuilder()
                 .WithAlgorithm(new HMACSHA256Algorithm())
                 .WithSecret(ConfigurationHelper.Configuration["JWT:Secret"])
                 .AddClaim("exp", DateTimeOffset.UtcNow.AddMinutes(expiryMinute).ToUnixTimeSeconds())
                 .AddClaim("_id", userId)
                 .Encode();
        }

        public async Task<ApiResponse> VerifyTokenChangePasswordAtFirstTIme(VerifyTokenChangePasswordAtFirstTImeModel model)
        {
            if (ParseTokenChangePassword(model.Token).Equals(Guid.Empty))
            {
                return ApiResponse.NotFound();
            }

            return ApiResponse.OK();
        }

        private Guid ParseTokenChangePassword(string token)
        {
            User user = null;
            try
            {
                var payload = new JwtBuilder()
                                           .WithAlgorithm(new HMACSHA256Algorithm())
                                           .WithSecret(ConfigurationHelper.Configuration["JWT:Secret"])
                                           .MustVerifySignature()
                                           .Decode<IDictionary<string, string>>(token);
                if (payload.TryGetValue("_id", out string idValue) && payload.TryGetValue("exp", out string expValue))
                {
                    user = _userRepository.FirstOrDefault(x => x.Id == Guid.Parse(idValue) && x.IsActivated && !x.IsDeleted);
                }
            }
            catch (Exception)
            {
            }

            if (user == null)
            {
                return Guid.Empty;
            }

            return user.Id;
        }

        public async Task<ApiResponse> ChangePasswordAtFirstTime(ChangePasswordAtFirstTimeModel model)
        {
            Guid userId = ParseTokenChangePassword(model.Token);
            if (userId.Equals(Guid.Empty))
            {
                return ApiResponse.NotFound();
            }

            if (!ValidateHelper.IsValidPassword(model.NewPassword))
            {
                return ApiResponse.BadRequest(UserMessageConst.InvalidPassword);
            }

            var passwordHashed = PasswordHelper.Hash(model.NewPassword);
            var user = _userRepository.FirstOrDefault(x => x.Id == userId);
            if (user == null)
            {
                return ApiResponse.NotFound();
            }

            user.Password = passwordHashed;

            _userRepository.Update(user);
            await _unitOfWork.SaveChanges();
         
            return ApiResponse.OK();
        }

        public async Task<ApiResponse> ResendEmailUserActivated(ResendEmailUserActivatedModel model)
        {
            var user = _userRepository.FirstOrDefault(x => x.Email == model.Email && x.IsActivated && !x.IsDeleted);
            if (user == null)
            {
                return ApiResponse.NotFound();
            }

            // generate accessToken
            var token = GenerateChangePasswordToken(user.Id);

            // send mail
            var system = _systemRepository.FirstOrDefault(x => x.Id == user.SystemId);
            var keyValue = new Dictionary<string, string>
                    {
                        { EmailTemplateKey.SystemName, system.Name },
                        { EmailTemplateKey.UserEmailAccount, user.Email },
                        { EmailTemplateKey.LinkChangePassword, GenerateHelper.ChangePasswordLink(token) }
                    };
            _ = Task.Run(() =>
            {
                _emailService.Send(user.Email, keyValue, EmailTemplateName.UserActivated, system.Name, EmailInfo.SubjectUserActivated);
            });

            return ApiResponse.OK();
        }
    }
}
