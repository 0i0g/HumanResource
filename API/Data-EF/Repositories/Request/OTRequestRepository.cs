using Data.Entities;
using System;
using System.Collections.Generic;
using System.Text;

namespace Data_EF.Repositories
{
    public class OTRequestRepository:Repository<OTRequest>, IOTRequestRepository
    {
        public OTRequestRepository(AppDbContext db):base(db)
        {
        }
    }
}
