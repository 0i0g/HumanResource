using System;
using System.Collections.Generic;
using System.Text;

namespace Data.Entities
{
    public class AuthUser
    {
        public Guid Id { get; set; }

        public bool IsAdmin { get; set; }

        public bool IsProjectManager { get; set; }

        public bool IsLineManager { get; set; }

        public bool IsEmployee { get; set; }
    }
}
