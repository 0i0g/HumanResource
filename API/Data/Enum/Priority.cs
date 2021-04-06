using System;
using System.Collections.Generic;
using System.Text;

namespace Data.Enum
{
    public static class Priority
    {
        public const int LOW = 0;
        public const int MEDIUM = 1;
        public const int HIGHT = 2;

        public static bool IsValid(int value)
        {
            return value >= 0 && value <= 2;
        }
    }
}
