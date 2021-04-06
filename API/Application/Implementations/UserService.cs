using Application.Interfaces;
using Application.RequestModels;
using Application.ViewModels;
using Data.Entities;
using Data.Enum;
using Data_EF;
using Data_EF.Repositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Utilities.Constants;
using Utilities.Extensions;
using Utilities.Helper;

namespace Application.Implementations
{
    public class UserService : BaseService, IUserService
    {
        private IUserRepository _userRepository;
        private ISystemRepository _systemRepository;
        private IAttendanceRepository _attendanceRepository;
        private IEmailService _emailService;

        public UserService(IUnitOfWork unitOfWork, IAuthService authService, IEmailService emailService) : base(unitOfWork, authService)
        {
            _userRepository = _unitOfWork.User;
            _systemRepository = _unitOfWork.System;
            _attendanceRepository = _unitOfWork.Attendance;
            _emailService = emailService;
        }

        public async Task<ApiResponse> GetProfile()
        {
            var user = _userRepository.FirstOrDefault(x => x.Id == _authService.User.Id);
            if (user == null)
            {
                return ApiResponse.NotFound();
            }

            return ApiResponse.OK(new UserProfile()
            {
                Email = user.Email,
                Fullname = user.Fullname,
                PhoneNumber = user.PhoneNumber,
                Gender = user.Gender,
                Role = user.Role,
                IsDeleted = user.IsDeleted,
                IsActivated = user.IsActivated
            });
        }

        public async Task<ApiResponse> CreateRegisterRequest(CreateRegisterRequestModel model)
        {
            #region Validate: Email, SystemCode, Fullname, PhoneNumber, Gender
            // Required
            if (string.IsNullOrWhiteSpace(model.Email) ||
                string.IsNullOrWhiteSpace(model.SystemCode) ||
                string.IsNullOrWhiteSpace(model.Fullname) ||
                string.IsNullOrWhiteSpace(model.PhoneNumber) ||
                !ValidateHelper.IsValidGender(model.Gender))
            {
                return ApiResponse.BadRequest();
            }
            // SystemCode
            var system = _systemRepository.FirstOrDefault(x => x.Code == model.SystemCode && !x.IsDeleted);
            if (system == null)
            {
                return ApiResponse.BadRequest(SystemMessageConst.CodeNotExist);
            }
            // Email
            if (!ValidateHelper.IsValidEmail(model.Email))
            {
                return ApiResponse.BadRequest(UserMessageConst.InvalidEmail);
            }
            var isEmailExisted = _userRepository.Contains(x => x.Username == model.Email && x.SystemId == system.Id);
            if (isEmailExisted)
            {
                return ApiResponse.BadRequest(UserMessageConst.DuplicateEmail);
            }
            // PhoneNumber
            if (!ValidateHelper.IsValidPhoneNumber(model.PhoneNumber))
            {
                return ApiResponse.BadRequest(UserMessageConst.InvalidPhoneNumber);
            }
            #endregion

            var user = new User()
            {
                Id = Guid.NewGuid(),
                Fullname = model.Fullname,
                PhoneNumber = model.PhoneNumber,
                Gender = model.Gender,
                Email = model.Email,
                SystemId = system.Id,
                Role = AppUserRole.EMPLOYEE,
                Username = model.Email,
                Password = PasswordHelper.Hash(GenerateHelper.RandomString(10))
            };
            _userRepository.Add(user);
            await _unitOfWork.SaveChanges();

            return ApiResponse.OK();
        }

        public async Task<ApiResponse> UpdateProfile(UpdateUserProfileModel model)
        {
            #region Validate: Fullname, PhoneNumber, Gender
            // Required
            if (string.IsNullOrWhiteSpace(model.Fullname) ||
                string.IsNullOrWhiteSpace(model.PhoneNumber) ||
                !ValidateHelper.IsValidGender(model.Gender))
            {
                return ApiResponse.BadRequest();
            }
            // PhoneNumber
            if (!ValidateHelper.IsValidPhoneNumber(model.PhoneNumber))
            {
                return ApiResponse.BadRequest(UserMessageConst.InvalidPhoneNumber);
            }
            #endregion

            var user = _userRepository.FirstOrDefault(x => x.Id == _authService.User.Id);
            if (user == null)
            {
                return ApiResponse.NotFound();
            }
            user.Fullname = model.Fullname ??= user.Fullname;
            user.PhoneNumber = model.PhoneNumber ??= user.PhoneNumber;
            user.Gender = model.Gender ??= user.Gender;

            _userRepository.Update(user);

            await _unitOfWork.SaveChanges();

            return ApiResponse.OK();
        }

        public async Task<ApiResponse> AcceptRegisterRequest(UserModel model)
        {
            if (!_authService.User.IsLineManager)
            {
                return ApiResponse.Forbidden();
            }

            var user = _userRepository.FirstOrDefault(x => x.Id == model.UserId);
            if (user == null)
            {
                return ApiResponse.NotFound();
            }

            if (user.IsActivated)
            {
                return ApiResponse.OK();
            }

            user.IsActivated = true;
            user.ActivatedBy = _authService.User.Id;
            user.ActivatedAt = DateTimeHelper.VnNow;

            var newPasword = GenerateHelper.RandomPassword(10);
            var passwordEncrypted = PasswordHelper.Hash(newPasword);
            user.Password = passwordEncrypted;

            // send mail
            var system = _systemRepository.FirstOrDefault(x => x.Id == user.SystemId);
            var keyValue = new Dictionary<string, string>
            {
                { EmailTemplateKey.SystemName, system.Name },
                { EmailTemplateKey.UserEmailAccount, user.Email },
                { EmailTemplateKey.NewPassword, newPasword }
            };

            _ = Task.Run(() =>
            {
                _emailService.Send(user.Email, keyValue, EmailTemplateName.UserActivated, system.Name, EmailInfo.SubjectUserActivated);
            });

            _userRepository.Update(user);
            await _unitOfWork.SaveChanges();

            return ApiResponse.OK();
        }

        public async Task<ApiResponse> RejectRegisterRequest(UserModel model)
        {
            if (!_authService.User.IsLineManager)
            {
                return ApiResponse.Forbidden();
            }

            var user = _userRepository.FirstOrDefault(x => x.Id == model.UserId);
            if (user == null)
            {
                return ApiResponse.NotFound();
            }

            if (user.IsDeleted)
            {
                return ApiResponse.OK();
            }

            user.IsDeleted = true;

            // send mail
            var system = _systemRepository.FirstOrDefault(x => x.Id == user.SystemId);
            var keyValue = new Dictionary<string, string>
                        {
                            { EmailTemplateKey.SystemName, system.Name },
                            { EmailTemplateKey.UserEmailAccount, user.Email }
                        };

            _ = Task.Run(() =>
            {
                _emailService.Send(user.Email, keyValue, EmailTemplateName.RegisterRequestRemoved, system.Name, EmailInfo.SubjectRegisterRequestRejected);
            });

            _userRepository.Update(user);
            await _unitOfWork.SaveChanges();

            return ApiResponse.OK();
        }

        public async Task<ApiResponse> CreateManagerUser(CreateManagerUserModel model)
        {
            if (!_authService.User.IsAdmin)
            {
                return ApiResponse.Forbidden();
            }

            if (!ValidateHelper.IsValidEmail(model.Email))
            {
                return ApiResponse.BadRequest(UserMessageConst.InvalidEmail);
            }

            var system = _systemRepository.FirstOrDefault(x => x.Id == model.SystemId && !x.IsDeleted);
            if (system == null)
            {
                return ApiResponse.BadRequest(UserMessageConst.SystemNotExist);
            }

            if (model.Role != AppUserRole.LINE_MANAGER && model.Role != AppUserRole.PROJECT_MANAGER)
            {
                return ApiResponse.BadRequest(UserMessageConst.InvalidRole);
            }

            var isEmailExisted = _userRepository.Contains(x => x.Username == model.Email && x.SystemId == model.SystemId);
            if (isEmailExisted)
            {
                return ApiResponse.BadRequest(UserMessageConst.DuplicateEmail);
            }

            var password = GenerateHelper.RandomPassword(10);
            var user = new User
            {
                Id = Guid.NewGuid(),
                Email = model.Email,
                Role = model.Role,
                Username = model.Email,
                Password = PasswordHelper.Hash(password),
                SystemId = system.Id,
                IsActivated = true
            };

            _userRepository.Add(user);
            await _unitOfWork.SaveChanges();

            // generate accessToken
            var token = _authService.GenerateChangePasswordToken(user.Id);

            // send mail
            var keyValue = new Dictionary<string, string>
            {
                { EmailTemplateKey.SystemName, system.Name },
                { EmailTemplateKey.UserEmailAccount, user.Email },
                { EmailTemplateKey.NewPassword, password }
            };

            _ = Task.Run(() =>
            {
                _emailService.Send(user.Email, keyValue, EmailTemplateName.UserActivated, system.Name, EmailInfo.SubjectUserActivated);
            });

            return ApiResponse.OK();
        }

        public async Task<ApiResponse> GetListManagerAccount()
        {
            if (!_authService.User.IsAdmin)
            {
                return ApiResponse.Forbidden();
            }

            var listManager = _userRepository.GetMany(x => x.Role == AppUserRole.LINE_MANAGER || x.Role == AppUserRole.PROJECT_MANAGER)
                .Select(x => new ManagerInformation
                {
                    Id = x.Id,
                    Username = x.Username,
                    Fullname = x.Fullname,
                    Role = x.Role,
                    IsDeleted = x.IsDeleted
                }).ToList();

            return ApiResponse.OK(listManager);
        }

        public async Task<ApiResponse> GetListEmployeeAccount()
        {
            if (!_authService.User.IsLineManager)
            {
                return ApiResponse.Forbidden();
            }

            var now = DateTime.Now;
            var listEmp = _userRepository.GetMany(x => x.Role == AppUserRole.EMPLOYEE)
                .GroupJoin(_attendanceRepository.GetMany(x => x.Checkin != null && x.Checkout != null && x.Date.Year.Equals(now.Year) && x.Date.Month.Equals(now.Month)), x => x.Id, y => y.UserId, (x, y) => new { User = x, Attendance = y })
                .SelectMany(x => x.Attendance.DefaultIfEmpty(), (x, y) => new EmployeeInformation
                {
                    Id = x.User.Id,
                    Username = x.User.Username,
                    Fullname = x.User.Fullname,
                    TotalDayWorking = y == null ? 0 : 1,
                    IsDeleted = x.User.IsDeleted
                })
                .AsEnumerable()
                .GroupBy(x=>x.Id)
                .Select(x=> new EmployeeInformation {
                    Id = x.Key,
                    Username = x.FirstOrDefault().Username,
                    Fullname = x.FirstOrDefault().Fullname,
                    TotalDayWorking = x.Where(x=>x.TotalDayWorking >0).Count(),
                    IsDeleted = x.FirstOrDefault().IsDeleted
                })
                .ToList();
            return ApiResponse.OK(listEmp);
        }

        public async Task<ApiResponse> GetListRegisterRequest()
        {
            var U = _authService.User;
            if (!U.IsLineManager)
            {
                return ApiResponse.Forbidden();
            }
            var systemId = _userRepository.GetMany(x => x.Id == U.Id)
                .Join(_systemRepository.GetAll(), x => x.SystemId, y => y.Id, (x, y) => y.Id).FirstOrDefault();

            var listReq = _userRepository.GetMany(x => !x.IsActivated && !x.IsDeleted && x.Role == AppUserRole.EMPLOYEE && x.SystemId == systemId)
                .Select(x => new RegisterRequestInformation
                {
                    Id = x.Id,
                    Email = x.Email,
                    Fullname = x.Fullname,
                    Gender = x.Gender,
                    PhoneNumber = x.PhoneNumber,
                    CreatedAt = x.CreatedAt
                });

            return ApiResponse.OK(listReq);
        }

        public async Task<ApiResponse> UpdateManagerAccount(UpdateManagerAccountModel model)
        {
            if (!_authService.User.IsAdmin)
            {
                return ApiResponse.Forbidden();
            }

            if (model.Role != AppUserRole.LINE_MANAGER && model.Role != AppUserRole.PROJECT_MANAGER)
            {
                return ApiResponse.BadRequest(UserMessageConst.InvalidRole);
            }

            var user = _userRepository.FirstOrDefault(x => x.Id == model.UserId);

            user.Role = model.Role ??= user.Role;
            user.IsDeleted = model.IsDeleted ??= user.IsDeleted;

            _userRepository.Update(user);
            await _unitOfWork.SaveChanges();

            return ApiResponse.OK();
        }

        public async Task<ApiResponse> UpdateEmployeeAccount(UpdateEmployeeAccountModel model)
        {
            if (!_authService.User.IsLineManager)
            {
                return ApiResponse.Forbidden();
            }

            var user = _userRepository.FirstOrDefault(x => x.Id == model.UserId);
            user.IsDeleted = model.IsDeleted ??= user.IsDeleted;

            _userRepository.Update(user);
            await _unitOfWork.SaveChanges();

            return ApiResponse.OK();
        }

        public async Task<ApiResponse> GetEmployeeProfile(UserModel model)
        {
            if (!_authService.User.IsLineManager)
            {
                return ApiResponse.Forbidden();
            }

            var user = _userRepository.FirstOrDefault(x => x.Id == model.UserId && x.Role == AppUserRole.EMPLOYEE);
            if (user == null)
            {
                return ApiResponse.NotFound();
            }

            return ApiResponse.OK(new UserProfile
            {
                Email = user.Email,
                Fullname = user.Fullname,
                Gender = user.Gender,
                PhoneNumber = user.PhoneNumber,
                Role = user.Role,
                IsDeleted = user.IsDeleted,
                IsActivated = user.IsActivated
            });
        }

        public async Task<ApiResponse> LineManagerCreateEmployee(LineManagerCreateEmployeeModel model)
        {
            var U = _authService.User;
            if (!U.IsLineManager)
            {
                return ApiResponse.Forbidden();
            }

            if (!ValidateHelper.IsValidEmail(model.Email)
                //|| !ValidateHelper.IsValidPhoneNumber(model.Phone) || !ValidateHelper.IsValidGender(model.Gender) || string.IsNullOrWhiteSpace(model.Fullname)
                )
            {
                return ApiResponse.BadRequest();
            }

            var isEmailExisted = _userRepository.Contains(x => x.Username == model.Email);
            if (isEmailExisted)
            {
                return ApiResponse.BadRequest(UserMessageConst.DuplicateEmail);
            }

            var systemId = _userRepository.GetMany(x => x.Id == U.Id)
                .Join(_systemRepository.GetAll(), x => x.SystemId, y => y.Id, (x, y) => new { y.Id }).FirstOrDefault().Id;

            var userId = Guid.NewGuid();
            _userRepository.Add(new User
            {
                Id = userId,
                Username = model.Email,
                Email = model.Email,
                //Fullname = model.Fullname,
                //PhoneNumber = model.Phone,
                //Gender = model.Gender,
                SystemId = systemId,
                Role = AppUserRole.EMPLOYEE,
            });

            await _unitOfWork.SaveChanges();
            await AcceptRegisterRequest(new UserModel { UserId = userId });

            return ApiResponse.OK();
        }

        private bool IsManager(User user)
        {
            return user.Role == AppUserRole.LINE_MANAGER || user.Role == AppUserRole.PROJECT_MANAGER;
        }
    }
}
