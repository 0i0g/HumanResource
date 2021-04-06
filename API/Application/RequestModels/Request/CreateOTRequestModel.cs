using System;
using System.Collections.Generic;
using System.Text;

namespace Application.RequestModels
{
    public class CreateOTRequestModel
    {
        public int TimeOT { get; set; }

        public DateTime FromDate { get; set; }

        public DateTime ToDate { get; set; }
    }
}
