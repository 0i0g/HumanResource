using System;
using System.Collections.Generic;
using System.Text;

namespace Application.ViewModels
{
    public class ListOTRequestItem
    {
        public Guid RequestId { get; set; }

        public UserDisplayInfo User{ get; set; }

        public int TimeOT { get; set; }

        public string FromDate { get; set; }

        public string ToDate { get; set; }

        public string Status { get; set; }
    }
}
