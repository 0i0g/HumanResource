using System;
using System.Collections.Generic;
using System.Text;

namespace Utilities.Helper
{
    public static class DateTimeHelper
    {
        public static DateTime VnNow { get { return DateTime.UtcNow.AddHours(7); } }

        public static String ToRoundedSecondsTimeString(this TimeSpan? time)
        {
            if (time == null)
            {
                return null;
            }

            var rounded = Math.Round(time.Value.TotalSeconds);
            return TimeSpan.FromSeconds(rounded).ToString();
        }

        public static bool IsToday(this DateTime date)
        {
            return date.Date.Equals(DateTimeHelper.VnNow.Date);
        }
    }
}
