using Data.Entities;
using Data.Enum;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Text;
using Utilities.Helper;

namespace Data_EF
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
        {
        }

        #region DbSet

        public DbSet<User> Users { get; set; }
        public DbSet<AppSystem> Systems { get; set; }
        public DbSet<AppTask> Tasks { get; set; }
        public DbSet<Attendance> Attendances { get; set; }
        public DbSet<DateTracking> DateTrackings { get; set; }
        public DbSet<DayOffRequest> DayOffRequests { get; set; }
        public DbSet<OTRequest> OTRequests { get; set; }
        public DbSet<AuthToken> AuthTokens { get; set; }

        #endregion

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            #region Default Value
            modelBuilder.Entity<User>().Property(p => p.Gender).HasDefaultValue(null);
            modelBuilder.Entity<User>().Property(p => p.ActivatedAt).HasDefaultValue(null);
            modelBuilder.Entity<User>().Property(p => p.Role).HasDefaultValue(AppUserRole.EMPLOYEE);
            modelBuilder.Entity<User>().Property(p => p.UpdatedAt).HasDefaultValue(null);
            modelBuilder.Entity<User>().Property(p => p.DeletedAt).HasDefaultValue(null);
            modelBuilder.Entity<User>().Property(p => p.Gender).HasDefaultValue(null);

            modelBuilder.Entity<AppSystem>().Property(p => p.UpdatedAt).HasDefaultValue(null);
            modelBuilder.Entity<AppSystem>().Property(p => p.DeletedAt).HasDefaultValue(null);

            modelBuilder.Entity<AppTask>().Property(p => p.Priority).HasDefaultValue(Priority.LOW);
            modelBuilder.Entity<AppTask>().Property(p => p.Status).HasDefaultValue(AppTaskStatus.OPEN);
            modelBuilder.Entity<AppTask>().Property(p => p.UpdatedAt).HasDefaultValue(null);
            modelBuilder.Entity<AppTask>().Property(p => p.DeletedAt).HasDefaultValue(null);

            modelBuilder.Entity<Attendance>().Property(p => p.Checkin).HasDefaultValue(null);
            modelBuilder.Entity<Attendance>().Property(p => p.Checkout).HasDefaultValue(null);

            modelBuilder.Entity<DayOffRequest>().Property(p => p.Status).HasDefaultValue(DayOffRequestStatus.WAITING);
            modelBuilder.Entity<DayOffRequest>().Property(p => p.UpdatedAt).HasDefaultValue(null);
            modelBuilder.Entity<DayOffRequest>().Property(p => p.DeletedAt).HasDefaultValue(null);

            modelBuilder.Entity<OTRequest>().Property(p => p.Status).HasDefaultValue(OTRequestStatus.WAITING);
            #endregion

            var defaultSystemId = Guid.NewGuid();

            modelBuilder.Entity<AppSystem>().HasData(new AppSystem
            {
                Id = defaultSystemId,
                Code = "T1",
                Name = "Default System",
                CreatedAt = DateTimeHelper.VnNow,
                UpdatedAt = DateTimeHelper.VnNow
            });

            modelBuilder.Entity<User>().HasData(new User
            {
                Id = Guid.NewGuid(),
                Username = "admin",
                Password = "21232f297a57a5a743894a0e4a801fc3", // admin
                Fullname = "Admin",
                Role = AppUserRole.ADMIN,
                IsActivated = true
            });

            modelBuilder.Entity<User>().HasData(new User
            {
                Id = Guid.NewGuid(),
                Username = "emp",
                Password = "4297f44b13955235245b2497399d7a93", // 123123
                Fullname = "Default Employee",
                Role = AppUserRole.EMPLOYEE,
                IsActivated = true,
                SystemId = defaultSystemId
            });

            modelBuilder.Entity<User>().HasData(new User
            {
                Id = Guid.NewGuid(),
                Username = "line",
                Password = "4297f44b13955235245b2497399d7a93", // 123123
                Fullname = "Default Line Manager",
                Role = AppUserRole.LINE_MANAGER,
                IsActivated = true,
                SystemId = defaultSystemId
            });

            modelBuilder.Entity<User>().HasData(new User
            {
                Id = Guid.NewGuid(),
                Username = "proj",
                Password = "4297f44b13955235245b2497399d7a93", // 123123
                Fullname = "Default Project Manager",
                Role = AppUserRole.PROJECT_MANAGER,
                IsActivated = true,
                SystemId = defaultSystemId
            });

            base.OnModelCreating(modelBuilder);
        }
    }
}
