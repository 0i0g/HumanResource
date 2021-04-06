using Application.Interfaces;
using MailKit.Net.Smtp;
using MailKit.Security;
using MimeKit;
using MimeKit.Text;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Utilities.Helper;

namespace Application.Implementations
{
    public class EmailService : IEmailService
    {
        public async Task Send(string receiver, Dictionary<string, string> keyValues, string templateName, string name, string subject)
        {
            if (!bool.Parse(ConfigurationHelper.Configuration.GetSection("Email:On").Value))
            {
                return;
            }
            var host = ConfigurationHelper.Configuration.GetSection("Email:SmtpHost").Value;
            var port = int.Parse(ConfigurationHelper.Configuration.GetSection("Email:SmtpPort").Value);
            var user = ConfigurationHelper.Configuration.GetSection("Email:User").Value;
            var password = ConfigurationHelper.Configuration.GetSection("Email:Password").Value;

            var systemEmail = ConfigurationHelper.Configuration.GetSection("Email:System:Email").Value;
            var content = GetHtmlFromTemplate(keyValues, templateName);

            var email = new MimeMessage();
            email.From.Add(new MailboxAddress(name, systemEmail));
            email.To.Add(MailboxAddress.Parse(receiver));
            email.Subject = subject;
            email.Body = new TextPart(TextFormat.Html) { Text = content };

            using var smtp = new SmtpClient();

            smtp.Connect(host, port, SecureSocketOptions.StartTls);
            smtp.Authenticate(user, password);
            smtp.Send(email);
            smtp.Disconnect(true);
        }

        private string GetHtmlFromTemplate(Dictionary<string, string> keyValues, string templateName)
        {
            var templateHelper = new EmailTemplateHelper();
            var content = templateHelper.GetTemplate(templateName);
            if (keyValues != null && keyValues.Any())
            {
                foreach (var value in keyValues)
                {
                    content = content.Replace(value.Key, value.Value);
                }
            }

            return content;
        }
    }
}
