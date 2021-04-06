using Application.RequestModels;
using Application.ViewModels;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace Application.Interfaces
{
    public interface IDayOffService
    {
        Task<ApiResponse> CreateDayOffRequest(CreateDayOffRequestModel model);

        Task<ApiResponse> GetListDayOffRequest();

        Task<ApiResponse> UpdateDayOffRequest(UpdateDayOffRequestModel model);
    }
}
