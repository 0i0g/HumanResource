using System;
using System.Collections.Generic;
using System.Text;

namespace Utilities.Extensions
{
    public static class StringExtensions
    {
        public static string ToGenderString(this bool? gender)
        {
            return gender == null ? null : (bool)gender ? "male" : "female";
        }
    }
}
