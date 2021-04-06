using System;
using System.Collections.Generic;
using System.Reflection;
using System.Text;
using System.Text.RegularExpressions;

namespace Utilities.Helper
{
    public static class ValidateHelper
    {
        public static bool IsValidEmail(string email)
        {
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);
                return addr.Address == email;
            }
            catch
            {
                return false;
            }
        }

        public static bool IsValidPhoneNumber(string phoneNumber)
        {
            return Regex.Match(phoneNumber, @"^[0-9]{6,15}$", RegexOptions.IgnoreCase).Success;
        }

        public static bool IsValidGender(string gender)
        {
            return gender.Equals("male") || gender.Equals("female");
        }

        public static bool IsValidPassword(string password)
        {
            return Regex.Match(password, @"^[A-z0-9]{3,15}$", RegexOptions.IgnoreCase).Success;
        }

        //public static bool EnumContains<T>(object value) where T : class
        //{
        //    var type = typeof(T);
        //    foreach (var p in type.GetProperties(BindingFlags.Static))
        //    {
        //        if (p.Equals(value))
        //        {
        //            return true;
        //        }
        //    }
        //    return 
        //}
    }
}
