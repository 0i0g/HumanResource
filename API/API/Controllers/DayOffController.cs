using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Application.Interfaces;
using Application.RequestModels;
using Application.ViewModels;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers
{
    public class DayOffController : BaseController
    {
        private IDayOffService _dayOffService;

        public DayOffController(IDayOffService dayOffService)
        {
            _dayOffService = dayOffService;
        }

        [Route("dayoff")]
        [HttpPost]
        public async Task<ApiResponse> Create(CreateDayOffRequestModel model)
        {
            return await _dayOffService.CreateDayOffRequest(model);
        }
        
        [Route("dayoff/listdayoff")]
        [HttpGet]
        public async Task<ApiResponse> GetAllDayOffRequest()
        {
            return await _dayOffService.GetListDayOffRequest();
        }

        [Route("dayoff")]
        [HttpPut]
        public async Task<ApiResponse> UpdateRequest(UpdateDayOffRequestModel model)
        {
            return await _dayOffService.UpdateDayOffRequest(model);
        }
    }
}
