using System;
using System.Collections.Generic;
using System.Text;

namespace Application.RequestModels
{
    public class ChangePasswordModel
    {
        public string OldPassword { get; set; }

        public string NewPassword { get; set; }
    }
}
