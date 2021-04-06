using System;
using System.Collections.Generic;
using System.Text;

namespace Application.ViewModels
{
    public class UserProfile
    {
        public string Fullname { get; set; }

        public string PhoneNumber { get; set; }

        public string Email { get; set; }

        public string Gender { get; set; }

        public int Role { get; set; }

        public bool IsDeleted { get; set; }

        public bool IsActivated { get; set; }
    }
}
