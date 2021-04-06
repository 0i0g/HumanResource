using Data.Entities;
using System;
using System.Collections.Generic;
using System.Text;

namespace Data_EF.Repositories
{
    public class TaskRepository:Repository<AppTask>, ITaskRepository
    {
        public TaskRepository(AppDbContext db):base(db)
        {
        }
    }
}
