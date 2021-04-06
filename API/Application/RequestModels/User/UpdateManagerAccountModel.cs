using System;
using System.Collections.Generic;
using System.Text;

namespace Application.RequestModels
{
    public class UpdateManagerAccountModel
    {
        public Guid UserId { get; set; }

        public int? Role { get; set; }

        public bool? IsDeleted { get; set; }
    }
}
