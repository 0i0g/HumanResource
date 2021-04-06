using System;
using System.Collections.Generic;
using System.Text;

namespace Application.ViewModels
{
    public class ListAttendanceItem
    {
        public string Date { get; set; }

        public string DayOfWeek { get; set; }

        public string CheckIn { get; set; }

        public string CheckOut { get; set; }

        public string Status { get; set; }
    }
}
