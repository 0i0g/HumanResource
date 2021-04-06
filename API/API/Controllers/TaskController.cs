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
    public class TaskController : BaseController
    {
        private ITaskService _taskService;

        public TaskController(ITaskService taskService)
        {
            _taskService = taskService;
        }


        [Route("task")]
        [HttpPost]
        public async Task<ApiResponse> CreateTask(CreateTaskModel model)
        {
            return await _taskService.CreateTask(model);
        }

        [Route("task/assignto")]
        [HttpPost]
        public async Task<ApiResponse> AssignTo(AssignTaskModel model)
        {
            return await _taskService.AssignTo(model);
        }

        [Route("task/listtask")]
        [HttpGet]
        public async Task<ApiResponse> GetListTask()
        {
            return await _taskService.GetListTask();
        }

        [Route("task")]
        [HttpGet]
        public async Task<ApiResponse> GetTask([FromQuery]TaskModel model)
        {
            return await _taskService.GetTask(model);
        }
        
        [Route("task")]
        [HttpPut]
        public async Task<ApiResponse> Update(UpdateTaskModel model)
        {
            return await _taskService.Update(model);
        }

        [Route("listemployeeavailabletask")]
        [HttpGet]
        public async Task<ApiResponse> GetEmployeeAvailableTask()
        {
            return await _taskService.GetEmployeeAvailableTask();
        }
    }
}
