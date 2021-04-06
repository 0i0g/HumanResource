using Data.Enum;
using System;
using System.Collections.Generic;
using System.Text;

namespace Data.Entities
{
    public class AppTask : SafeEntity
    {
        public Guid Id { get; set; }

        public string Title { get; set; }

        public string Description { get; set; }

        public int Priority { get; set; }

        public Guid Assignee { get; set; }

        public string Status { get; set; }

        public int Process { get; set; }
    }
}
