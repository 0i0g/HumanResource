using Data.Entities;
using System;
using System.Collections.Generic;
using System.Text;

namespace Data_EF.Repositories
{
    public class DayOffRequestRepository:Repository<DayOffRequest>, IDayOffRequestRepository
    {
        public DayOffRequestRepository(AppDbContext db):base(db)
        {
        }
    }
}
