using System;
using System.Collections.Generic;
using System.Text;

namespace Application.RequestModels
{
    public class CreateDayOffRequestModel
    {
        public DateTime FromDate { get; set; }
        
        public DateTime ToDate { get; set; }
    }
}
