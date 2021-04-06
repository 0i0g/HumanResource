using System;
using System.Collections.Generic;
using System.Text;

namespace Application.RequestModels
{
    public class UpdateUserProfileModel
    {
        public string Fullname { get; set; }

        public string PhoneNumber { get; set; }

        public string Gender { get; set; }
    }
}
