using System;
using System.Collections.Generic;
using System.Text;

namespace Application.RequestModels
{
    public class UpdateDayOffRequestModel
    {
        public Guid RequestId { get; set; }

        public string Status { get; set; }
    }
}
