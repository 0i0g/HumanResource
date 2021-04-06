using System;
using System.Collections.Generic;
using System.Text;

namespace Application.RequestModels
{
    public class CreateManagerUserModel
    {
        public string Email { get; set; }

        public Guid SystemId { get; set; }

        public int Role { get; set; }
    }
}
