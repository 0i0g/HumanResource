using System;
using System.Collections.Generic;
using System.Text;

namespace Data.Entities
{
    public class AuthToken
    {
        public Guid Id { get; set; }

        public Guid UserId { get; set; }

        public string RefreshToken { get; set; }
    }
}
