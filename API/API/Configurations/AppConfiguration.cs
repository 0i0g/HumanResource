using API.Configurations.Middleware;
using Application.Implementations;
using Application.Interfaces;
using Data_EF;
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace API.Configurations
{
    public static class AppConfiguration
    {
        public static void AddDependenceInjection(this IServiceCollection services)
        {
            #region DI

            services.AddHttpContextAccessor();
            services.AddSingleton<IFirebaseService, FirebaseService>();

            // Every request
            services.AddScoped<IAuthService, AuthService>();
            services.AddScoped<IUserService, UserService>();
            services.AddScoped<ISystemService, SystemService>();
            services.AddScoped<IEmailService, EmailService>();
            services.AddScoped<ITaskService, TaskService>();
            services.AddScoped<IAttendanceService, AttendanceService>();
            services.AddScoped<IDayOffService, DayOffService>();
            services.AddScoped<IOTService, OTService>();
            services.AddScoped<IDashboardService, DashboardService>();

            // Every controller and every service
            services.AddTransient<IUnitOfWork, UnitOfWork>();

            #endregion
        }

        public static void UseJWT(this IApplicationBuilder app)
        {
            app.UseMiddleware<JwtMiddleware>();
        }
    }
}
