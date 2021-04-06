using Data.Entities;
using System;
using System.Collections.Generic;
using System.Text;

namespace Data_EF.Repositories
{
    public class AttendanceRepository : Repository<Attendance>, IAttendanceRepository
    {
        public AttendanceRepository(AppDbContext db) : base(db)
        {
        }
    }
}
