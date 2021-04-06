using Data.Entities;
using System;
using System.Collections.Generic;
using System.Text;

namespace Data_EF.Repositories
{
    public class DateTrackingRepository : Repository<DateTracking>, IDateTrackingRepository
    {
        public DateTrackingRepository(AppDbContext db) : base(db)
        {
        }
    }
}
