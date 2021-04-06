using System;
using System.Collections.Generic;
using System.Text;

namespace Application.ViewModels
{
    public class ListTaskItem
    {
        public Guid Id { get; set; }

        public string Title { get; set; }

        public string Description { get; set; }

        public int Priority { get; set; }

        public UserDisplayInfo? Assignee { get; set; }

        public string Status { get; set; }

        public int Process { get; set; }

        public string CreatedAt { get; set; }

        public UserDisplayInfo CreatedBy { get; set; }
    }
}
