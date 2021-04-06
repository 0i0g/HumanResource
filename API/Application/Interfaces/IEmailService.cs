using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace Application.Interfaces
{
    public interface IEmailService
    {
        Task Send(string receiver, Dictionary<string, string> keyValues, string templateName, string name, string subject);
    }
}
