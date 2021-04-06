using System;
using System.Collections.Generic;
using System.Security.Cryptography;
using System.Text;

namespace Utilities.Helper
{
    public static class PasswordHelper
    {
        public static string Hash(string password)
        {
            var md5Hash = MD5.Create();
            var data = md5Hash.ComputeHash(Encoding.UTF8.GetBytes(password));
            var sBuilder = new StringBuilder();
            foreach (var t in data)
            {
                sBuilder.Append(t.ToString("x2"));
            }
            return sBuilder.ToString();
        }
    }
}
