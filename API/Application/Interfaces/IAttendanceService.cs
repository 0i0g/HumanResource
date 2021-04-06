using Application.RequestModels;
using Application.ViewModels;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace Application.Interfaces
{
    public interface IAttendanceService
    {
        Task<ApiResponse> CheckIn();

        Task<ApiResponse> CheckOut();

        Task<ApiResponse> ViewAttendance(ViewAttendanceModel model);
    }
}
