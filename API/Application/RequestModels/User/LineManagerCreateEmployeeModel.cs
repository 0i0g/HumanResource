using System;
using System.Collections.Generic;
using System.Text;

namespace Application.RequestModels
{
    public class LineManagerCreateEmployeeModel
    {
        public string Email { get; set; }
        
        public string Phone { get; set; }

        public string Gender{ get; set; }

        public string Fullname { get; set; }
    }
}
