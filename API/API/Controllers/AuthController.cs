using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Application.Interfaces;
using Application.RequestModels;
using Application.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers
{
    public class AuthController : BaseController
    {
        private IAuthService _authService;
        private IHostingEnvironment _hostingEnvironment;

        public AuthController(IAuthService authService, IHostingEnvironment hostingEnvironment)
        {
            _authService = authService;
            _hostingEnvironment = hostingEnvironment;
        }

        [Route("")]
        [HttpGet]
        [AllowAnonymous]
        public async Task<ApiResponse> Welcome()
        {
            return ApiResponse.OK("Welcome to HumanResource");
        }

        [Route("env")]
        [HttpGet]
        [AllowAnonymous]
        public async Task<ApiResponse> Environment()
        {
            return ApiResponse.OK(new { Name = _hostingEnvironment.EnvironmentName });
        }


        [Route("auth/login")]
        [HttpPost]
        [AllowAnonymous]
        public async Task<ApiResponse> Login(UserLoginModel model)
        {
            return await _authService.Login(model);
        }

        [Route("auth/getaccesstoken")]
        [HttpPost]
        [AllowAnonymous]
        public async Task<ApiResponse> GetAccessToken(GetAccessTokenModel model)
        {
            return await _authService.GetAccessToken(model);
        }

        [Route("auth/changepassword")]
        [HttpPost]
        public async Task<ApiResponse> ChangePassword(ChangePasswordModel model)
        {
            return await _authService.ChangePassword(model);
        }

        [Route("auth/verifytokenchangepasswordatfirsttime")]
        [HttpPost]
        [AllowAnonymous]
        public async Task<ApiResponse> VerifyTokenChangePasswordAtFirstTIme(VerifyTokenChangePasswordAtFirstTImeModel model)
        {
            return await _authService.VerifyTokenChangePasswordAtFirstTIme(model);
        }

        [Route("auth/changepasswordatfirsttimemodel")]
        [HttpPost]
        [AllowAnonymous]
        public async Task<ApiResponse> ChangePasswordAtFirstTime(ChangePasswordAtFirstTimeModel model)
        {
            return await _authService.ChangePasswordAtFirstTime(model);
        }
        
        [Route("auth/resendemailuseractivatedmodel")]
        [HttpPost]
        [AllowAnonymous]
        public async Task<ApiResponse> ResendEmailUserActivated(ResendEmailUserActivatedModel model)
        {
            return await _authService.ResendEmailUserActivated(model);
        }


    }
}
