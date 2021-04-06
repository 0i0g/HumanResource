using Application.RequestModels;
using Application.ViewModels;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace Application.Interfaces
{
    public interface ISystemService
    {
        Task<ApiResponse> CreateSystem(CreateSystemModel model);

        Task<ApiResponse> GetListSystem();

        Task<ApiResponse> Update(UpdateSystemModel model);
    }
}
