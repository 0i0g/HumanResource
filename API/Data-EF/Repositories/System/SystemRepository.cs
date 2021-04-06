using Data.Entities;
using System;
using System.Collections.Generic;
using System.Text;

namespace Data_EF.Repositories
{
    public class SystemRepository : Repository<AppSystem>, ISystemRepository
    {
        public SystemRepository(AppDbContext db) : base(db)
        {
        }
    }
}
