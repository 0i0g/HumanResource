using System;
using System.Collections.Generic;
using System.Text;

namespace Application.RequestModels
{
    public class UpdateSystemModel
    {
        public Guid Id { get; set; }

        public string Name { get; set; }

        public string Code { get; set; }

        public bool? IsDeleted { get; set; }
    }
}
