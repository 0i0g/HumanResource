using System;
using System.Collections.Generic;
using System.Text;

namespace Utilities.Constants
{
    public static class MessageConst
    {
    }

    public static class SystemMessageConst
    {
        public const string DuplicateCode = "1001";
        public const string CodeNotExist = "1002";
    }

    public static class UserMessageConst
    {
        public const string InvalidEmail = "2001";
        public const string DuplicateEmail = "2002";
        public const string InvalidPhoneNumber = "2003";
        public const string UserDeleted = "2004";
        public const string SystemDeleted = "2005";
        public const string SystemNotExist = "2006";
        public const string InvalidRole = "2007";
        public const string InvalidPassword = "2008";
        public const string PleaseActiveUser = "2009";
        public const string NotExist = "2010";
    }

    public static class TaskMessageConst
    {
        public const string NotExist = "3001";
    }

    public static class RequestMessageConst
    {
        public const string Duplicate = "4001";
        public const string InvalidStatus = "4002";
    }

    public static class AttendanceMessageConst
    {
        public const string CheckedIn = "5001";
        public const string CheckedOut = "5002";
        public const string NotCheckedIn = "5003";
    }
}
