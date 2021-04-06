using Data.Entities;
using System;
using System.Collections.Generic;
using System.Text;

namespace Data_EF.Repositories
{
    public class UserRepository : Repository<User>, IUserRepository
    {
        public UserRepository(AppDbContext db) : base(db)
        {
        }
    }
}
