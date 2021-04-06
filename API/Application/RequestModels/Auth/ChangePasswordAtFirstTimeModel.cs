using System;
using System.Collections.Generic;
using System.Text;

namespace Application.RequestModels
{
    public class ChangePasswordAtFirstTimeModel
    {
        public string Token { get; set; }

        public string NewPassword { get; set; }
    }
}
