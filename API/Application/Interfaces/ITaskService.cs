using Application.RequestModels;
using Application.ViewModels;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace Application.Interfaces
{
    public interface ITaskService
    {
        Task<ApiResponse> CreateTask(CreateTaskModel model);

        Task<ApiResponse> AssignTo(AssignTaskModel model);
        
        Task<ApiResponse> GetListTask();
        
        Task<ApiResponse> GetTask(TaskModel model);

        Task<ApiResponse> Update(UpdateTaskModel model);

        Task<ApiResponse> GetEmployeeAvailableTask();
    }
}
