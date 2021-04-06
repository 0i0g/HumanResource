using System;
using System.Collections.Generic;
using System.Text;

namespace Data.Entities
{
    public class DateTracking
    {
        public Guid Id { get; set; }

        public Guid UserId { get; set; }

        public DateTime Date { get; set; }

        public int MinutesWorked { get; set; } // minutes

        public bool HasOTRequest { get; set; }

        public int HoursOTRequested { get; set; }

        public int MinutesOTCompleted { get; set; }

        public bool HasDayOffRequest { get; set; }
    }
}
