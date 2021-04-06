using System;
using System.Collections.Generic;
using System.Text;

namespace Application.RequestModels
{
    public class UpdateTaskModel
    {
        public Guid Id { get; set; }

        public string Title { get; set; }

        public string Description { get; set; }

        public int? Priority { get; set; }

        public string Status { get; set; }

        public int? Process { get; set; }

        public bool? IsDeleted { get; set; }
    }
}
