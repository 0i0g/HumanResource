using Application.Interfaces;
using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace API.Configurations.Middleware
{
    public class JwtMiddleware
    {
        #region Properties

        private readonly RequestDelegate _next;

        #endregion

        #region Constructor

        public JwtMiddleware(RequestDelegate next)
        {
            _next = next;
        }

        #endregion

        #region Invoke

        /// <summary>
        /// Invokes the specified context.
        /// </summary>
        /// <param name="context">The context.</param>
        /// <param name="userService">The user service.</param>
        public async Task Invoke(HttpContext context, IAuthService userService)
        {
            var token = context.Request.Headers["x-access-token"].FirstOrDefault();

            if (token != null)
            {
                context.Items["User"] = userService.VerifyToken(token);
            }

            await _next(context);
        }

        #endregion
    }
}
