using System;
using System.Collections.Generic;
using System.Text;

namespace Application.RequestModels
{
    public class AssignTaskModel
    {
        public Guid TaskId { get; set; }

        public Guid UserId { get; set; }
    }
}
