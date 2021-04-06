using System;
using System.Collections.Generic;
using System.Text;

namespace Data.Entities
{
    public class Attendance
    {
        public Guid Id { get; set; }

        public Guid UserId { get; set; }

        public DateTime Date { get; set; }

        public TimeSpan? Checkin { get; set; }
     
        public TimeSpan? Checkout { get; set; }
    }
}
