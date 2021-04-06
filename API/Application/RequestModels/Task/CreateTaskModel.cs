using System;
using System.Collections.Generic;
using System.Text;

namespace Application.RequestModels
{
    public class CreateTaskModel
    {
        public string Title { get; set; }

        public string Description { get; set; }

        public int Priority { get; set; }
    }
}
