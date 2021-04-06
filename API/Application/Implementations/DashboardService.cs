using Application.Interfaces;
using Application.ViewModels;
using Data.Enum;
using Data_EF;
using Data_EF.Repositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Utilities.Helper;

namespace Application.Implementations
{
    public class DashboardService : BaseService, IDashboardService
    {
        private ITaskRepository _taskRepository;
        private IAttendanceRepository _attendanceRepository;
        private IOTRequestRepository _OTRequestRepository;
        private IDayOffRequestRepository _dayOffRequestRepository;

        public DashboardService(IUnitOfWork unitOfWork, IAuthService authService) : base(unitOfWork, authService)
        {
            _taskRepository = unitOfWork.Task;
            _attendanceRepository = unitOfWork.Attendance;
            _OTRequestRepository = unitOfWork.OTRequest;
            _dayOffRequestRepository = unitOfWork.DayOffRequest;
        }

        public async Task<ApiResponse> GetMobileDashboard()
        {
            var U = _authService.User;
            if (!U.IsEmployee)
            {
                return ApiResponse.Forbidden();
            }

            var totalTask = _taskRepository.GetMany(x => x.Assignee == U.Id && !x.IsDeleted && (x.Status == AppTaskStatus.OPEN || x.Status == AppTaskStatus.REOPEN)).ToList().Count;

            var now = DateTimeHelper.VnNow;
            var checkInCheckOut = _attendanceRepository.FirstOrDefault(x => x.UserId == U.Id && x.Date.Date == now.Date);

            var checkInCheckOutState = 0;
            if (checkInCheckOut != null)
            {
                if (checkInCheckOut.Checkin != null && checkInCheckOut.Checkout == null)
                {
                    checkInCheckOutState = 1;
                }
                else if (checkInCheckOut.Checkin != null && checkInCheckOut.Checkout != null)
                {
                    checkInCheckOutState = 2;
                }
            }

            var totalWaitingRequest = _dayOffRequestRepository.GetMany(x => x.UserId == U.Id && !x.IsDeleted && x.Status == DayOffRequestStatus.WAITING).ToList().Count;

            totalWaitingRequest += _OTRequestRepository.GetMany(x => x.UserId == U.Id && !x.IsDeleted && x.Status == OTRequestStatus.WAITING).ToList().Count;

            return ApiResponse.OK(new MobileDashboard
            {
                TotalTask = totalTask,
                CheckInCheckOutState = checkInCheckOutState,
                TotalWaitingRequest = totalWaitingRequest
            });
        }
    }
}
