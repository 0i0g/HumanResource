using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace Data_EF.Migrations
{
    public partial class UpdateOTrequestDaterange2 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Systems",
                keyColumn: "Id",
                keyValue: new Guid("0e30f6c8-d1b8-4143-a108-0347b4f348bc"));

            migrationBuilder.DeleteData(
                table: "Users",
                keyColumn: "Id",
                keyValue: new Guid("1d9b8521-224d-4d87-9522-663c6f14b642"));

            migrationBuilder.DeleteData(
                table: "Users",
                keyColumn: "Id",
                keyValue: new Guid("28fd721c-848d-48b2-95a1-1096e182b9cd"));

            migrationBuilder.DeleteData(
                table: "Users",
                keyColumn: "Id",
                keyValue: new Guid("68bc61a3-3e91-4fd8-886b-f8faac4a3c73"));

            migrationBuilder.DeleteData(
                table: "Users",
                keyColumn: "Id",
                keyValue: new Guid("72d39934-5695-4359-96d0-14a641bac45c"));

            migrationBuilder.RenameColumn(
                name: "UserOT",
                table: "OTRequests",
                newName: "UserId");

            migrationBuilder.InsertData(
                table: "Systems",
                columns: new[] { "Id", "Code", "CreatedAt", "CreatedBy", "DeletedAt", "DeletedBy", "IsDeleted", "Name", "UpdatedAt", "UpdatedBy" },
                values: new object[] { new Guid("bf807616-a770-4bb3-90ae-8f97ddcbf076"), "T1", new DateTime(2021, 3, 6, 14, 29, 47, 378, DateTimeKind.Utc).AddTicks(175), new Guid("00000000-0000-0000-0000-000000000000"), null, new Guid("00000000-0000-0000-0000-000000000000"), false, "Default System", new DateTime(2021, 3, 6, 14, 29, 47, 378, DateTimeKind.Utc).AddTicks(1240), new Guid("00000000-0000-0000-0000-000000000000") });

            migrationBuilder.InsertData(
                table: "Users",
                columns: new[] { "Id", "ActivatedAt", "ActivatedBy", "CreatedAt", "CreatedBy", "DeletedAt", "DeletedBy", "Email", "Fullname", "Gender", "IsActivated", "IsDeleted", "Password", "PhoneNumber", "Role", "SystemId", "UpdatedAt", "UpdatedBy", "Username" },
                values: new object[,]
                {
                    { new Guid("16efa5d0-985d-475f-9fbf-028074fc77b6"), null, new Guid("00000000-0000-0000-0000-000000000000"), new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new Guid("00000000-0000-0000-0000-000000000000"), null, new Guid("00000000-0000-0000-0000-000000000000"), null, "Admin", null, true, false, "21232f297a57a5a743894a0e4a801fc3", null, 9999, new Guid("00000000-0000-0000-0000-000000000000"), null, new Guid("00000000-0000-0000-0000-000000000000"), "admin" },
                    { new Guid("44052829-10ef-468c-aab8-692f3544cff2"), null, new Guid("00000000-0000-0000-0000-000000000000"), new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new Guid("00000000-0000-0000-0000-000000000000"), null, new Guid("00000000-0000-0000-0000-000000000000"), null, "Default Employee", null, true, false, "4297f44b13955235245b2497399d7a93", null, 3, new Guid("bf807616-a770-4bb3-90ae-8f97ddcbf076"), null, new Guid("00000000-0000-0000-0000-000000000000"), "emp" },
                    { new Guid("ce0f7fcf-6b5f-4ab0-91a0-0d2b7318c33f"), null, new Guid("00000000-0000-0000-0000-000000000000"), new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new Guid("00000000-0000-0000-0000-000000000000"), null, new Guid("00000000-0000-0000-0000-000000000000"), null, "Default Line Manager", null, true, false, "4297f44b13955235245b2497399d7a93", null, 2, new Guid("bf807616-a770-4bb3-90ae-8f97ddcbf076"), null, new Guid("00000000-0000-0000-0000-000000000000"), "line" },
                    { new Guid("98e4a966-d7eb-41a3-9963-3107565e7119"), null, new Guid("00000000-0000-0000-0000-000000000000"), new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new Guid("00000000-0000-0000-0000-000000000000"), null, new Guid("00000000-0000-0000-0000-000000000000"), null, "Default Project Manager", null, true, false, "4297f44b13955235245b2497399d7a93", null, 1, new Guid("bf807616-a770-4bb3-90ae-8f97ddcbf076"), null, new Guid("00000000-0000-0000-0000-000000000000"), "proj" }
                });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Systems",
                keyColumn: "Id",
                keyValue: new Guid("bf807616-a770-4bb3-90ae-8f97ddcbf076"));

            migrationBuilder.DeleteData(
                table: "Users",
                keyColumn: "Id",
                keyValue: new Guid("16efa5d0-985d-475f-9fbf-028074fc77b6"));

            migrationBuilder.DeleteData(
                table: "Users",
                keyColumn: "Id",
                keyValue: new Guid("44052829-10ef-468c-aab8-692f3544cff2"));

            migrationBuilder.DeleteData(
                table: "Users",
                keyColumn: "Id",
                keyValue: new Guid("98e4a966-d7eb-41a3-9963-3107565e7119"));

            migrationBuilder.DeleteData(
                table: "Users",
                keyColumn: "Id",
                keyValue: new Guid("ce0f7fcf-6b5f-4ab0-91a0-0d2b7318c33f"));

            migrationBuilder.RenameColumn(
                name: "UserId",
                table: "OTRequests",
                newName: "UserOT");

            migrationBuilder.InsertData(
                table: "Systems",
                columns: new[] { "Id", "Code", "CreatedAt", "CreatedBy", "DeletedAt", "DeletedBy", "IsDeleted", "Name", "UpdatedAt", "UpdatedBy" },
                values: new object[] { new Guid("0e30f6c8-d1b8-4143-a108-0347b4f348bc"), "T1", new DateTime(2021, 3, 6, 14, 16, 13, 480, DateTimeKind.Utc).AddTicks(8433), new Guid("00000000-0000-0000-0000-000000000000"), null, new Guid("00000000-0000-0000-0000-000000000000"), false, "Default System", new DateTime(2021, 3, 6, 14, 16, 13, 480, DateTimeKind.Utc).AddTicks(9086), new Guid("00000000-0000-0000-0000-000000000000") });

            migrationBuilder.InsertData(
                table: "Users",
                columns: new[] { "Id", "ActivatedAt", "ActivatedBy", "CreatedAt", "CreatedBy", "DeletedAt", "DeletedBy", "Email", "Fullname", "Gender", "IsActivated", "IsDeleted", "Password", "PhoneNumber", "Role", "SystemId", "UpdatedAt", "UpdatedBy", "Username" },
                values: new object[,]
                {
                    { new Guid("68bc61a3-3e91-4fd8-886b-f8faac4a3c73"), null, new Guid("00000000-0000-0000-0000-000000000000"), new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new Guid("00000000-0000-0000-0000-000000000000"), null, new Guid("00000000-0000-0000-0000-000000000000"), null, "Admin", null, true, false, "21232f297a57a5a743894a0e4a801fc3", null, 9999, new Guid("00000000-0000-0000-0000-000000000000"), null, new Guid("00000000-0000-0000-0000-000000000000"), "admin" },
                    { new Guid("72d39934-5695-4359-96d0-14a641bac45c"), null, new Guid("00000000-0000-0000-0000-000000000000"), new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new Guid("00000000-0000-0000-0000-000000000000"), null, new Guid("00000000-0000-0000-0000-000000000000"), null, "Default Employee", null, true, false, "4297f44b13955235245b2497399d7a93", null, 3, new Guid("0e30f6c8-d1b8-4143-a108-0347b4f348bc"), null, new Guid("00000000-0000-0000-0000-000000000000"), "emp" },
                    { new Guid("1d9b8521-224d-4d87-9522-663c6f14b642"), null, new Guid("00000000-0000-0000-0000-000000000000"), new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new Guid("00000000-0000-0000-0000-000000000000"), null, new Guid("00000000-0000-0000-0000-000000000000"), null, "Default Line Manager", null, true, false, "4297f44b13955235245b2497399d7a93", null, 2, new Guid("0e30f6c8-d1b8-4143-a108-0347b4f348bc"), null, new Guid("00000000-0000-0000-0000-000000000000"), "line" },
                    { new Guid("28fd721c-848d-48b2-95a1-1096e182b9cd"), null, new Guid("00000000-0000-0000-0000-000000000000"), new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new Guid("00000000-0000-0000-0000-000000000000"), null, new Guid("00000000-0000-0000-0000-000000000000"), null, "Default Project Manager", null, true, false, "4297f44b13955235245b2497399d7a93", null, 1, new Guid("0e30f6c8-d1b8-4143-a108-0347b4f348bc"), null, new Guid("00000000-0000-0000-0000-000000000000"), "proj" }
                });
        }
    }
}
