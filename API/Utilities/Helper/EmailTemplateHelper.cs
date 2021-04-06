using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace Utilities.Helper
{
    public class EmailTemplateHelper
    {
        private string DataPath;

        public EmailTemplateHelper()
        {
            DataPath = ConfigurationHelper.Configuration.GetSection("DataPath:EmailTemplate").Value;
        }

        public string GetTemplate(string templateName)
        {
            var path = Path.Combine(Environment.CurrentDirectory, DataPath, templateName);
            return File.ReadAllText(Path.Combine(Environment.CurrentDirectory, DataPath, templateName), Encoding.UTF8);
        }
    }

    public static class EmailTemplateKey
    {
        public const string SystemName = "{{System Name}}";
        public const string UserEmailAccount = "{{User Email Account}}";
        public const string LinkChangePassword = "{{Link Change Password}}";
        public const string NewPassword = "{{New Password}}";
    }

    public static class EmailInfo
    {
        public const string SystemDefaultName = "Human Resource";
        public const string SubjectUserActivated = "Account is now active";
        public const string SubjectRegisterRequestRejected = "Your register request is rejected";
    }

    public static class EmailTemplateName
    {
        public const string UserActivated = "UserActivated.html";
        public const string RegisterRequestRemoved = "RegisterRequestRemoved.html";

    }
}
