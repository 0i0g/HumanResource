using System;
using System.Collections.Generic;
using System.Text;

namespace Application.ViewModels
{
    public class ManagerInformation
    {
        public Guid Id { get; set; }

        public string Username { get; set; }

        public string Fullname { get; set; }

        public bool IsDeleted { get; set; }

        public int Role { get; set; }
    }
}
