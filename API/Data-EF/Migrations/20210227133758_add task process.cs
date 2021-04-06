using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace Data_EF.Migrations
{
    public partial class addtaskprocess : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Systems",
                keyColumn: "Id",
                keyValue: new Guid("b2129339-8f1b-4c06-8aca-e02cabfff6dc"));

            migrationBuilder.DeleteData(
                table: "Users",
                keyColumn: "Id",
                keyValue: new Guid("275470ec-ba74-41c4-8d96-3323484e35c4"));

            migrationBuilder.AddColumn<int>(
                name: "Process",
                table: "Tasks",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.InsertData(
                table: "Systems",
                columns: new[] { "Id", "Code", "CreatedAt", "CreatedBy", "DeletedAt", "DeletedBy", "IsDeleted", "Name", "UpdatedAt", "UpdatedBy" },
                values: new object[] { new Guid("8826932a-38ef-42c5-aaaa-e9c30d989cc5"), "T1", new DateTime(2021, 2, 27, 20, 37, 58, 202, DateTimeKind.Utc).AddTicks(7875), new Guid("00000000-0000-0000-0000-000000000000"), null, new Guid("00000000-0000-0000-0000-000000000000"), false, "Default System", new DateTime(2021, 2, 27, 20, 37, 58, 202, DateTimeKind.Utc).AddTicks(8982), new Guid("00000000-0000-0000-0000-000000000000") });

            migrationBuilder.InsertData(
                table: "Users",
                columns: new[] { "Id", "ActivatedAt", "ActivatedBy", "CreatedAt", "CreatedBy", "DeletedAt", "DeletedBy", "Email", "Fullname", "Gender", "IsActivated", "IsDeleted", "Password", "PhoneNumber", "Role", "SystemId", "UpdatedAt", "UpdatedBy", "Username" },
                values: new object[] { new Guid("73034b71-0f22-48e8-9978-4d95fed05e4d"), null, new Guid("00000000-0000-0000-0000-000000000000"), new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new Guid("00000000-0000-0000-0000-000000000000"), null, new Guid("00000000-0000-0000-0000-000000000000"), null, "Admin", null, true, false, "21232f297a57a5a743894a0e4a801fc3", null, 9999, new Guid("00000000-0000-0000-0000-000000000000"), null, new Guid("00000000-0000-0000-0000-000000000000"), "admin" });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Systems",
                keyColumn: "Id",
                keyValue: new Guid("8826932a-38ef-42c5-aaaa-e9c30d989cc5"));

            migrationBuilder.DeleteData(
                table: "Users",
                keyColumn: "Id",
                keyValue: new Guid("73034b71-0f22-48e8-9978-4d95fed05e4d"));

            migrationBuilder.DropColumn(
                name: "Process",
                table: "Tasks");

            migrationBuilder.InsertData(
                table: "Systems",
                columns: new[] { "Id", "Code", "CreatedAt", "CreatedBy", "DeletedAt", "DeletedBy", "IsDeleted", "Name", "UpdatedAt", "UpdatedBy" },
                values: new object[] { new Guid("b2129339-8f1b-4c06-8aca-e02cabfff6dc"), "T1", new DateTime(2021, 2, 14, 1, 12, 43, 432, DateTimeKind.Utc).AddTicks(3810), new Guid("00000000-0000-0000-0000-000000000000"), null, new Guid("00000000-0000-0000-0000-000000000000"), false, "Default System", new DateTime(2021, 2, 14, 1, 12, 43, 432, DateTimeKind.Utc).AddTicks(4410), new Guid("00000000-0000-0000-0000-000000000000") });

            migrationBuilder.InsertData(
                table: "Users",
                columns: new[] { "Id", "ActivatedAt", "ActivatedBy", "CreatedAt", "CreatedBy", "DeletedAt", "DeletedBy", "Email", "Fullname", "Gender", "IsActivated", "IsDeleted", "Password", "PhoneNumber", "Role", "SystemId", "UpdatedAt", "UpdatedBy", "Username" },
                values: new object[] { new Guid("275470ec-ba74-41c4-8d96-3323484e35c4"), null, new Guid("00000000-0000-0000-0000-000000000000"), new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new Guid("00000000-0000-0000-0000-000000000000"), null, new Guid("00000000-0000-0000-0000-000000000000"), null, "Admin", null, true, false, "21232f297a57a5a743894a0e4a801fc3", null, 9999, new Guid("00000000-0000-0000-0000-000000000000"), null, new Guid("00000000-0000-0000-0000-000000000000"), "admin" });
        }
    }
}
