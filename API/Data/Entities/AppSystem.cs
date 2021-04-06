using System;
using System.Collections.Generic;
using System.Text;

namespace Data.Entities
{
    public class AppSystem : SafeEntity
    {
        public Guid Id { get; set; }

        public string Code { get; set; }

        public string Name { get; set; }
    }
}
