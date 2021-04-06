using Application.Interfaces;
using Application.RequestModels;
using Application.ViewModels;
using Data.Entities;
using Data.Enum;
using Data_EF;
using Data_EF.Repositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Utilities.Constants;

namespace Application.Implementations
{
    public class TaskService : BaseService, ITaskService
    {
        private IUserRepository _userRepository;
        private ITaskRepository _taskRepository;
        private ISystemRepository _systemRepository;
        private IEmailService _emailService;

        public TaskService(IUnitOfWork unitOfWork, IAuthService authService, IEmailService emailService) : base(unitOfWork, authService)
        {
            _userRepository = _unitOfWork.User;
            _taskRepository = _unitOfWork.Task;
            _systemRepository = _unitOfWork.System;
            _emailService = emailService;
        }

        public async Task<ApiResponse> AssignTo(AssignTaskModel model)
        {
            var task = _taskRepository.FirstOrDefault(x => x.Id == model.TaskId && !x.IsDeleted);
            var isEmplExisted = _userRepository.Contains(x => x.Id == model.UserId && x.IsActivated && !x.IsDeleted);
            if (!isEmplExisted)
            {
                return ApiResponse.BadRequest(UserMessageConst.UserDeleted);
            }
            if (task == null)
            {
                return ApiResponse.BadRequest(TaskMessageConst.NotExist);
            }

            task.Assignee = model.UserId;
            _taskRepository.Update(task);

            await _unitOfWork.SaveChanges();

            return ApiResponse.OK();
        }

        public async Task<ApiResponse> CreateTask(CreateTaskModel model)
        {
            var U = _authService.User;
            if (!U.IsProjectManager)
            {
                return ApiResponse.Forbidden();
            }

            model.Priority = Priority.IsValid(model.Priority) ? model.Priority : Priority.MEDIUM;

            var task = new AppTask
            {
                Id = Guid.NewGuid(),
                Title = model.Title,
                Description = model.Description,
                Priority = model.Priority,
                Process = 0
            };

            if (U.IsEmployee)
            {
                task.Assignee = U.Id;
            }

            _taskRepository.Add(task);
            await _unitOfWork.SaveChanges();

            return ApiResponse.OK();
        }

        public async Task<ApiResponse> GetListTask()
        {
            var U = _authService.User;
            if (!U.IsProjectManager && !U.IsEmployee)
            {
                return ApiResponse.Forbidden();
            }

            var systemId = _userRepository.GetMany(x => x.Id == U.Id)
                .Join(_systemRepository.GetAll(), x => x.SystemId, y => y.Id, (x, y) => new { y.Id }).FirstOrDefault().Id;

            var users = _userRepository.GetMany(x => x.SystemId == systemId);
            var t = users.ToList();
            var taskAsigneeTo = _taskRepository.GetMany(x => !x.IsDeleted).Join(users, x => x.Assignee, y => y.Id, (x, y) => new ListTaskItem
            {
                Id = x.Id,
                Assignee = new UserDisplayInfo { Id = y.Id, Username = y.Username, Fullname = y.Fullname },
                CreatedAt = x.CreatedAt.ToShortDateString(),
                CreatedBy = new UserDisplayInfo { Id = x.CreatedBy },
                Description = x.Description,
                Priority = x.Priority,
                Process = x.Process,
                Status = x.Status,
                Title = x.Title
            })
                .Join(_userRepository.GetAll(), x => x.CreatedBy.Id, y => y.Id, (x, y) => new ListTaskItem
                {
                    Id = x.Id,
                    Assignee = x.Assignee,
                    CreatedAt = x.CreatedAt,
                    CreatedBy = new UserDisplayInfo { Id = y.Id, Fullname = y.Fullname, Username = y.Username },
                    Description = x.Description,
                    Priority = x.Priority,
                    Status = x.Status,
                    Title = x.Title,
                    Process = x.Process
                }).ToList();

            var taskCreatedBy = _taskRepository.GetMany(x => !x.IsDeleted).Join(users, x => x.CreatedBy, y => y.Id, (x, y) => new ListTaskItem
            {
                Id = x.Id,
                CreatedBy = new UserDisplayInfo { Id = y.Id, Username = y.Username, Fullname = y.Fullname },
                CreatedAt = x.CreatedAt.ToShortDateString(),
                Assignee = new UserDisplayInfo { Id = x.CreatedBy },
                Description = x.Description,
                Priority = x.Priority,
                Process = x.Process,
                Status = x.Status,
                Title = x.Title
            }).GroupJoin(_userRepository.GetAll(), x => x.Assignee.Id, y => y.Id, (x, y) => new { Task = x, User = y })
            .SelectMany(x => x.User.DefaultIfEmpty(), (x, y) => new ListTaskItem
            {
                Id = x.Task.Id,
                CreatedBy = x.Task.CreatedBy,
                CreatedAt = x.Task.CreatedAt,
                Assignee = y == null ? null : new UserDisplayInfo { Id = y.Id, Fullname = y.Fullname, Username = y.Username },
                Description = x.Task.Description,
                Priority = x.Task.Priority,
                Status = x.Task.Status,
                Title = x.Task.Title,
                Process = x.Task.Process
            }).ToList();

            var result = taskAsigneeTo.Concat(taskCreatedBy).GroupBy(x => x.Id).Select(x => x.First()).ToList();

            return ApiResponse.OK(result);
        }

        public async Task<ApiResponse> GetTask(TaskModel model)
        {
            var U = _authService.User;
            if (!U.IsProjectManager && !U.IsEmployee)
            {
                return ApiResponse.Forbidden();
            }

            var task = _taskRepository.GetMany(x => x.Id == model.TaskId)
                .GroupJoin(_userRepository.GetAll(), x => x.Assignee, y => y.Id, (x, y) => new { Task = x, User = y })
                .SelectMany(x => x.User.DefaultIfEmpty(), (x, y) => new TaskViewModel
                {
                    Id = x.Task.Id,
                    Assignee = y == null ? null : new UserDisplayInfo { Id = y.Id, Username = y.Username, Fullname = y.Fullname },
                    CreatedAt = x.Task.CreatedAt.ToString(),
                    CreatedBy = new UserDisplayInfo { Id = x.Task.CreatedBy },
                    Description = x.Task.Description,
                    Priority = x.Task.Priority,
                    Process = x.Task.Process,
                    Status = x.Task.Status,
                    Title = x.Task.Title
                })
                .GroupJoin(_userRepository.GetAll(), x => x.CreatedBy.Id, y => y.Id, (x, y) => new
                {
                    Task = x,
                    User = y
                })
                .SelectMany(x => x.User.DefaultIfEmpty(), (x, y) => new TaskViewModel
                {
                    Id = x.Task.Id,
                    Assignee = x.Task.Assignee,
                    CreatedAt = x.Task.CreatedAt,
                    CreatedBy = y == null ? null : new UserDisplayInfo { Id = y.Id, Username = y.Username, Fullname = y.Fullname },
                    Description = x.Task.Description,
                    Priority = x.Task.Priority,
                    Process = x.Task.Process,
                    Status = x.Task.Status,
                    Title = x.Task.Title
                }).FirstOrDefault();

            if (task == null)
            {
                return ApiResponse.NotFound();
            }

            return ApiResponse.OK(task);
        }

        public async Task<ApiResponse> Update(UpdateTaskModel model)
        {
            var U = _authService.User;
            if (!U.IsProjectManager && !U.IsEmployee)
            {
                return ApiResponse.Forbidden();
            }

            var task = _taskRepository.FirstOrDefault(x => x.Id == model.Id);
            if (task == null)
            {
                return ApiResponse.NotFound();
            }

            task.Title = model.Title ??= task.Title;
            task.Description = model.Description ??= task.Description;
            task.Priority = model.Priority ??= task.Priority;
            task.Status = model.Status ??= task.Status;
            task.IsDeleted = model.IsDeleted ??= task.IsDeleted;
            task.Process = model.Process ??= task.Process;

            _taskRepository.Update(task);
            await _unitOfWork.SaveChanges();

            return ApiResponse.OK();
        }

        public async Task<ApiResponse> GetEmployeeAvailableTask()
        {
            var U = _authService.User;
            if (!U.IsProjectManager)
            {
                return ApiResponse.Forbidden();
            }

            var systemId = _userRepository.GetMany(x => x.Id == U.Id)
                .Join(_systemRepository.GetAll(), x => x.SystemId, y => y.Id, (x, y) => new { y.Id }).FirstOrDefault().Id;

            var availabelUsers = _userRepository.GetMany(x => x.SystemId == systemId && !x.IsDeleted && x.IsActivated && x.Role == AppUserRole.EMPLOYEE)
                .GroupJoin(_taskRepository.GetMany(x => !x.IsDeleted && (x.Status == AppTaskStatus.OPEN || x.Status == AppTaskStatus.REOPEN)), x => x.Id, y => y.Assignee, (x, y) => new { User = x, Task = y })
                .SelectMany(x => x.Task.DefaultIfEmpty(), (x, y) =>
                 new
                 {
                     User = new UserDisplayInfo
                     {
                         Id = x.User.Id,
                         Username = x.User.Username,
                         Fullname = x.User.Fullname
                     },
                     Status = y == null ? EmployeeWorkingStatus.FREE : EmployeeWorkingStatus.HASTASK
                 })
                .Where(x => x.Status == EmployeeWorkingStatus.FREE)
                .GroupBy(x => x.User)
                  .Select(x => new AvailabelUsersItem
                  {
                      User = new UserDisplayInfo { Id = x.Key.Id, Username = x.Key.Username, Fullname = x.Key.Fullname }
                  })
                .ToList();

            return ApiResponse.OK(availabelUsers);
        }
    }
}
