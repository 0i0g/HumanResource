using System;
using System.Collections.Generic;
using System.Text;

namespace Application.RequestModels
{
    public class UpdateEmployeeAccountModel
    {
        public Guid UserId { get; set; }

        public bool? IsDeleted { get; set; }
    }
}
