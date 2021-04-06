using Application.Interfaces;
using Application.ViewModels;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace API.Controllers
{
    public class DashboardController : BaseController
    {
        private IDashboardService _dashboardService;

        public DashboardController(IDashboardService dashboardService)
        {
            _dashboardService = dashboardService;
        }

        [Route("dashboard/mobile")]
        [HttpGet]
        public async Task<ApiResponse> GetMobileDashboard()
        {
            return await _dashboardService.GetMobileDashboard();
        }
    }
}
