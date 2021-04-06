using System;
using System.Collections.Generic;
using System.Text;
using Utilities.Extensions;

namespace Data.Enum
{
    public static class AppTaskStatus
    {
        public const string OPEN = "open";
        public const string REOPEN = "reopen";
        public const string RESOLVED = "resolved";
        public const string CLOSED = "closed";
    }

    public static class OTRequestStatus
    {
        public const string WAITING = "submited";
        public const string APPROVED = "accepted";
        public const string CANCELED = "rejected";
    }

    public static class DayOffRequestStatus 
    {
        public const string WAITING = "submited";
        public const string APPROVED = "accepted";
        public const string CANCELED = "rejected";
    }

    public static class AttendanceStatus
    {
        public const string ATTENDED = "attended";
        public const string ABSENT = "absent";
        public const string WARNING = "warning";
    }

    public static class EmployeeWorkingStatus
    {
        public const string FREE = "free";
        public const string HASTASK = "hastask";
    }
}
