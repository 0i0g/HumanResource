using System;
using System.Collections.Generic;
using System.Text;

namespace Application.RequestModels
{
    public class CreateRegisterRequestModel
    {
        public string Fullname { get; set; }

        public string PhoneNumber { get; set; }

        public string Gender { get; set; }

        public string Email { get; set; }

        public string SystemCode { get; set; }
    }
}
