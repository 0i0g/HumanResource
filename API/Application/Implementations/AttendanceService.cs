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
using Utilities.Helper;

namespace Application.Implementations
{
    public class AttendanceService : BaseService, IAttendanceService
    {
        private IAttendanceRepository _attendanceRepository;

        public AttendanceService(IUnitOfWork unitOfWork, IAuthService authService) : base(unitOfWork, authService)
        {
            _attendanceRepository = unitOfWork.Attendance;
        }

        public async Task<ApiResponse> CheckIn()
        {
            var U = _authService.User;
            if (!U.IsEmployee)
            {
                return ApiResponse.Forbidden();
            }

            DateTime now = DateTimeHelper.VnNow;
            var isCheckedIn = _attendanceRepository.FirstOrDefault(x => x.Date.Date.Equals(now.Date) && x.Checkin != null && x.UserId == U.Id);
            if (isCheckedIn != null)
            {
                return ApiResponse.BadRequest(AttendanceMessageConst.CheckedIn);
            }

            _attendanceRepository.Add(new Attendance
            {
                Id = Guid.NewGuid(),
                Date = now.Date,
                Checkin = now.TimeOfDay,
                UserId = U.Id
            });
            await _unitOfWork.SaveChanges();
            return ApiResponse.OK();
        }

        public async Task<ApiResponse> CheckOut()
        {
            var U = _authService.User;
            if (!U.IsEmployee)
            {
                return ApiResponse.Forbidden();
            }

            DateTime now = DateTimeHelper.VnNow;
            var attendance = _attendanceRepository.FirstOrDefault(x => x.UserId == U.Id && now.Date.Equals(x.Date.Date) && x.Checkin != null);
            if (attendance == null)
            {
                return ApiResponse.BadRequest(AttendanceMessageConst.NotCheckedIn);
            }
            var isCheckedOut = _attendanceRepository.FirstOrDefault(x => x.Date.Date.Equals(now.Date) && x.Checkout != null && x.UserId == U.Id);
            if (isCheckedOut != null)
            {
                return ApiResponse.BadRequest(AttendanceMessageConst.CheckedOut);
            }

            attendance.Checkout = now.TimeOfDay;
            _attendanceRepository.Update(attendance);
            await _unitOfWork.SaveChanges();
            return ApiResponse.OK();
        }

        public async Task<ApiResponse> ViewAttendance(ViewAttendanceModel model)
        {
            var U = _authService.User;
            if (!U.IsEmployee)
            {
                return ApiResponse.Forbidden();
            }

            var now = DateTimeHelper.VnNow.Date;
            var dayOfWeek = now.DayOfWeek;
            var daysPassedMonday = 0;
            if (dayOfWeek == DayOfWeek.Sunday)
            {
                daysPassedMonday = 6;
            }
            else
            {
                daysPassedMonday = dayOfWeek - DayOfWeek.Monday;
            }

            var fromDate = now.AddDays(-daysPassedMonday);
            var toDate = fromDate.AddDays(7);

            var attendance = _attendanceRepository.GetMany(x => x.Date >= fromDate && x.Date <= toDate && x.UserId == U.Id)
                .Select(x => new ListAttendanceItem
                {
                    DayOfWeek = x.Date.DayOfWeek.ToString(),
                    Date = x.Date.ToShortDateString(),
                    CheckIn = x.Checkin.ToRoundedSecondsTimeString(),
                    CheckOut = x.Checkout.ToRoundedSecondsTimeString(),
                    Status = AttendanceStatus.ATTENDED
                }).ToList();

            return ApiResponse.OK(attendance);
        }
    }
}
