using Data_EF.Repositories;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace Data_EF
{
    public interface IUnitOfWork
    {
        #region Repositories

        public IUserRepository User { get; }
        public ISystemRepository System { get; }
        public ITaskRepository Task { get; }
        public IAttendanceRepository Attendance { get; }
        public IDateTrackingRepository DateTracking { get; }
        public IDayOffRequestRepository DayOffRequest { get; }
        public IOTRequestRepository OTRequest { get; }
        public IAuthTokenRepository AuthToken { get; }

        #endregion

        #region DB method

        Task<int> SaveChanges();

        #endregion
    }
}
