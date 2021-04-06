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
    public class SystemController : BaseController
    {
        private ISystemService _systemService;
        private IFirebaseService _firebaseService;


        public SystemController(ISystemService systemService, IFirebaseService firebaseService)
        {
            _systemService = systemService;
            _firebaseService = firebaseService;
        }

        [Route("system")]
        [HttpPost]
        public async Task<ApiResponse> Create(CreateSystemModel model)
        {
            return await _systemService.CreateSystem(model);
        }

        [Route("system/test")]
        [HttpGet]
        [AllowAnonymous]
        public async Task<ApiResponse> Test()
        {
            await _firebaseService.Test();
            return ApiResponse.OK();
        }

        [Route("system/list")]
        [HttpGet]
        public async Task<ApiResponse> GetListSystem()
        {
            return await _systemService.GetListSystem();
        }
    }
}
