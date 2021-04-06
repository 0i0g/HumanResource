using System;
using System.Collections.Generic;
using System.Text;

namespace Application.ViewModels
{
    public class EmployeeInformation
    {
        public Guid Id { get; set; }

        public string Username { get; set; }

        public string Fullname { get; set; }

        public int TotalDayWorking { get; set; }

        public bool IsDeleted { get; set; }
    }
}
