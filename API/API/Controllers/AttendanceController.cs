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
    public class AttendanceController : BaseController
    {
        private IAttendanceService _attendanceService;

        public AttendanceController(IAttendanceService attendanceService)
        {
            _attendanceService = attendanceService;
        }

        [Route("attendance/checkin")]
        [HttpPost]
        public async Task<ApiResponse> CheckIn()
        {
            return await _attendanceService.CheckIn();
        }

        [Route("attendance/checkout")]
        [HttpPost]
        public async Task<ApiResponse> CheckOut()
        {
            return await _attendanceService.CheckOut();
        }
        
        [Route("attendance")]
        [HttpGet]
        public async Task<ApiResponse> ViewAttendance([FromQuery]ViewAttendanceModel model)
        {
            return await _attendanceService.ViewAttendance(model);
        }
    }
}
