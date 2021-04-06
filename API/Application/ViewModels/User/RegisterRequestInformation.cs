using System;
using System.Collections.Generic;
using System.Text;

namespace Application.ViewModels
{
    public class RegisterRequestInformation
    {
        public Guid Id { get; set; }

        public string Email { get; set; }

        public string Fullname { get; set; }

        public string PhoneNumber { get; set; }

        public string Gender { get; set; }

        public DateTime CreatedAt { get; set; }
    }
}
