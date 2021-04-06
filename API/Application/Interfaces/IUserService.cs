using Application.RequestModels;
using Application.ViewModels;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace Application.Interfaces
{
    public interface IUserService
    {
        Task<ApiResponse> GetProfile();

        Task<ApiResponse> CreateRegisterRequest(CreateRegisterRequestModel model);

        Task<ApiResponse> UpdateProfile(UpdateUserProfileModel model);

        Task<ApiResponse> AcceptRegisterRequest(UserModel model);

        Task<ApiResponse> RejectRegisterRequest(UserModel model);

        Task<ApiResponse> CreateManagerUser(CreateManagerUserModel model);

        Task<ApiResponse> GetListManagerAccount();

        Task<ApiResponse> GetListEmployeeAccount();

        Task<ApiResponse> GetListRegisterRequest();

        Task<ApiResponse> UpdateManagerAccount(UpdateManagerAccountModel model);

        Task<ApiResponse> UpdateEmployeeAccount(UpdateEmployeeAccountModel model);

        Task<ApiResponse> GetEmployeeProfile(UserModel model);

        Task<ApiResponse> LineManagerCreateEmployee(LineManagerCreateEmployeeModel model);
    }
}
