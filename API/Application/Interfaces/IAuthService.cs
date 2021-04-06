using Application.RequestModels;
using Application.ViewModels;
using Data.Entities;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace Application.Interfaces
{
    public interface IAuthService
    {
        AuthUser User { get; }

        Task<ApiResponse> Login(UserLoginModel model);

        Task<ApiResponse> GetAccessToken(GetAccessTokenModel model);

        AuthUser VerifyToken(string token);

        Task<ApiResponse> ChangePassword(ChangePasswordModel model);

        string GenerateChangePasswordToken(Guid userId);

        Task<ApiResponse> VerifyTokenChangePasswordAtFirstTIme(VerifyTokenChangePasswordAtFirstTImeModel token);

        Task<ApiResponse> ChangePasswordAtFirstTime(ChangePasswordAtFirstTimeModel model);

        Task<ApiResponse> ResendEmailUserActivated(ResendEmailUserActivatedModel model);
    }
}
