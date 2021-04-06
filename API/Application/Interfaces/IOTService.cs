using Application.RequestModels;
using Application.ViewModels;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace Application.Interfaces
{
    public interface IOTService
    {
        Task<ApiResponse> CreateOTRequest(CreateOTRequestModel model);
     
        Task<ApiResponse> GetListOTRequest();
     
        Task<ApiResponse> UpdateOTRequest(UpdateOTRequestModel model);
    }
}
