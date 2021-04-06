using System;
using System.Collections.Generic;
using System.Text;

namespace Data.Entities
{
    public class User : SafeEntity
    {
        public Guid Id { get; set; }

        public string Username { get; set; }

        public string Password { get; set; }

        public string Email { get; set; }

        public string Fullname { get; set; }

        public string PhoneNumber { get; set; }

        public string Gender { get; set; }

        public DateTime? ActivatedAt { get; set; }

        public Guid ActivatedBy { get; set; }

        public bool IsActivated { get; set; }

        public Guid SystemId { get; set; }

        public int Role { get; set; }
    }
}
