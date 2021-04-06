using Application.Interfaces;
using Application.RequestModels;
using Application.ViewModels;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace API.Controllers
{
    public class OTController:BaseController
    {
        private IOTService _OTService;

        public OTController(IOTService OTService)
        {
            _OTService = OTService;
        }

        [Route("ot")]
        [HttpPost]
        public async Task<ApiResponse> Create(CreateOTRequestModel model)
        {
            return await _OTService.CreateOTRequest(model);
        }

        [Route("ot/listot")]
        [HttpGet]
        public async Task<ApiResponse> GetAllOTRequest()
        {
            return await _OTService.GetListOTRequest();
        }

        [Route("ot")]
        [HttpPut]
        public async Task<ApiResponse> UpdateOTRequest(UpdateOTRequestModel model)
        {
            return await _OTService.UpdateOTRequest(model);
        }
    }
}
