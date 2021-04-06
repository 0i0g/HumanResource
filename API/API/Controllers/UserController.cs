using Application.Interfaces;
using Application.RequestModels;
using Application.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace API.Controllers
{
    public class UserController : BaseController
    {
        private IUserService _userService;

        public UserController(IUserService userService) 
        {
            _userService = userService;
        }

        [Route("user/profile")]
        [HttpGet]
        public async Task<ApiResponse> GetProfile()
        {
            return await _userService.GetProfile();
        }

        [Route("user/registerrequest")]
        [HttpPost]
        [AllowAnonymous]
        public async Task<ApiResponse> CreateRegisterRequest(CreateRegisterRequestModel model)
        {
            return await _userService.CreateRegisterRequest(model);
        }

        [Route("user")]
        [HttpPut]
        public async Task<ApiResponse> UpdateProfile(UpdateUserProfileModel model)
        {
            return await _userService.UpdateProfile(model);
        }
        
        [Route("user/acceptregisterrequest")]
        [HttpPost]
        public async Task<ApiResponse> AcceptRegisterRequest(UserModel model)
        {
            return await _userService.AcceptRegisterRequest(model);
        }

        [Route("user/rejectregisterrequest")]
        [HttpPost]
        public async Task<ApiResponse> RejectRegisterRequest(UserModel model)
        {
            return await _userService.RejectRegisterRequest(model);
        }

        [Route("user/createmanager")]
        [HttpPost]
        public async Task<ApiResponse> CreateManagerUser(CreateManagerUserModel model)
        {
            return await _userService.CreateManagerUser(model);
        }
        
        [Route("user/listmanager")]
        [HttpGet]
        public async Task<ApiResponse> GetListManagerAccount()
        {
            return await _userService.GetListManagerAccount();
        }
        
        [Route("user/listemployee")]
        [HttpGet]
        public async Task<ApiResponse> GetListEmployeeAccount()
        {
            return await _userService.GetListEmployeeAccount();
        }

        [Route("user/updatemanager")]
        [HttpPut]
        public async Task<ApiResponse> UpdateManagerAccount(UpdateManagerAccountModel model)
        {
            return await _userService.UpdateManagerAccount(model);
        }

        [Route("user/updateemployee")]
        [HttpPut]
        public async Task<ApiResponse> UpdateEmployeeAccount(UpdateEmployeeAccountModel model)
        {
            return await _userService.UpdateEmployeeAccount(model);
        }


        [Route("user/employeeprofile")]
        [HttpGet]
        public async Task<ApiResponse> GetEmployeeProfile([FromQuery]UserModel model)
        {
            return await _userService.GetEmployeeProfile(model);
        }
        
        [Route("user/listregisterrequest")]
        [HttpGet]
        public async Task<ApiResponse> GetListRegisterRequest()
        {
            return await _userService.GetListRegisterRequest();
        }

        [Route("user/linemanagercreateemployee")]
        [HttpPost]
        public async Task<ApiResponse> LineManagerCreateEmployee(LineManagerCreateEmployeeModel model)
        {
            return await _userService.LineManagerCreateEmployee(model);
        }
    }
}
