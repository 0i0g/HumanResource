using Data.Entities;
using System;
using System.Collections.Generic;
using System.Text;

namespace Data_EF.Repositories
{
    public class AuthTokenRepository:Repository<AuthToken>, IAuthTokenRepository
    {
        public AuthTokenRepository(AppDbContext db):base(db)
        {
        }
    }
}
