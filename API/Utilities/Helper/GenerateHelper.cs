using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Utilities.Helper
{
    public static class GenerateHelper
    {
        public static string RandomString(int length)
        {
            var random = new Random();
            const string chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            return new string(Enumerable.Repeat(chars, length).Select(s => s[random.Next(s.Length)]).ToArray());
        }

        public static string ChangePasswordLink(string accessToken)
        {
            var domain = ConfigurationHelper.Configuration.GetSection("Domain:FE").Value;
            var url = domain + "/changepassword?token=" + accessToken;
            return url;
        }

        public static string RandomPassword(int length)
        {
            var random = new Random();
            const string chars = "abcdefghijklmnopqrstuvwxyz0123456789";
            return new string(Enumerable.Repeat(chars, length).Select(s => s[random.Next(s.Length)]).ToArray());
        }
    }
}
