using Data.Entities;
using Data_EF.Repositories;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Utilities.Helper;

namespace Data_EF
{
    public class UnitOfWork : IUnitOfWork, IDisposable
    {
        private AppDbContext _db;
        private readonly IHttpContextAccessor _httpContextAccessor;

        #region Repositories

        private IUserRepository _user;
        private ISystemRepository _system;
        private ITaskRepository _task;
        private IAttendanceRepository _attendance;
        private IDateTrackingRepository _dateTracking;
        private IDayOffRequestRepository _dayOffRequest;
        private IOTRequestRepository _OTRequest;
        private IAuthTokenRepository _authToken;

        #endregion

        public UnitOfWork(AppDbContext db, IHttpContextAccessor httpContextAccessor)
        {
            _db = db;
            _httpContextAccessor = httpContextAccessor;
        }

        #region Get Repositories

        public IUserRepository User
        {
            get { return _user ??= new UserRepository(_db); }
        }

        public ISystemRepository System
        {
            get { return _system ??= new SystemRepository(_db); }
        }

        public ITaskRepository Task
        {
            get { return _task ??= new TaskRepository(_db); }
        }

        public IAttendanceRepository Attendance
        {
            get { return _attendance ??= new AttendanceRepository(_db); }
        }

        public IDateTrackingRepository DateTracking
        {
            get { return _dateTracking ??= new DateTrackingRepository(_db); }
        }

        public IDayOffRequestRepository DayOffRequest
        {
            get { return _dayOffRequest ??= new DayOffRequestRepository(_db); }
        }

        public IOTRequestRepository OTRequest
        {
            get { return _OTRequest ??= new OTRequestRepository(_db); }
        }

        public IAuthTokenRepository AuthToken
        {
            get { return _authToken ??= new AuthTokenRepository(_db); }
        }

        #endregion

        #region DB method

        public async Task<int> SaveChanges()
        {
            var now = DateTimeHelper.VnNow;
            AuthUser user = null;
            try
            {
                user = (AuthUser)_httpContextAccessor.HttpContext.Items["User"];
            }
            catch (Exception e)
            {
            }
            var addedEntries = _db.ChangeTracker.Entries().Where(x => x.State == EntityState.Added);
            foreach (var entry in addedEntries)
            {
                try
                {
                    var safeEntry = ((SafeEntity)entry.Entity);
                    safeEntry.CreatedAt = now;
                    safeEntry.CreatedBy = user.Id;
                }
                catch (Exception)
                {
                }
            }

            var modifiedEntries = _db.ChangeTracker.Entries().Where(x => x.State == EntityState.Modified);
            foreach (var entry in modifiedEntries)
            {
                bool isDeleted = false;
                foreach (var pro in entry.Entity.GetType().GetProperties())
                {
                    if (pro.Name.Equals("IsDeleted"))
                    {
                        if (entry.CurrentValues[pro.Name] is bool current && entry.OriginalValues[pro.Name] is bool original)
                        {
                            if (!original && current)
                            {
                                isDeleted = true;
                            }
                        }
                        break;
                    }
                }

                try
                {
                    var safeEntry = ((SafeEntity)entry.Entity);
                    if (isDeleted)
                    {
                        safeEntry.DeletedAt = now;
                        safeEntry.DeletedBy = user.Id;
                    }
                    else
                    {
                        safeEntry.UpdatedAt = now;
                        safeEntry.UpdatedBy = user.Id;
                    }
                }
                catch (Exception)
                {
                }
            }

            return await this._db.SaveChangesAsync();
        }

        #endregion

        public void Dispose()
        {
            _db.Dispose();
        }
    }
}
