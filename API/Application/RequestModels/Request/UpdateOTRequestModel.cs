using System;
using System.Collections.Generic;
using System.Text;

namespace Application.RequestModels
{
    public class UpdateOTRequestModel
    {
        public Guid RequestId { get; set; }

        public string Status { get; set; }
    }
}
