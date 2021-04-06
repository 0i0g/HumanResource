using System;
using System.Collections.Generic;
using System.Text;

namespace Application.RequestModels
{
    public class GetAccessTokenModel
    {
        public Guid UserId { get; set; }

        public string RefreshToken { get; set; }
    }
}
