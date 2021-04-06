using System;
using System.Collections.Generic;
using System.Text;

namespace Data.Entities
{
    public class DayOffRequest : SafeEntity
    {
        public Guid Id { get; set; }

        public Guid UserId { get; set; }

        public DateTime FromDate { get; set; }

        public DateTime ToDate { get; set; }

        public string Status { get; set; }
    }
}
