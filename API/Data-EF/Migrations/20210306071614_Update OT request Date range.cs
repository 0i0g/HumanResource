using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace Data_EF.Migrations
{
    public partial class UpdateOTrequestDaterange : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Systems",
                keyColumn: "Id",
                keyValue: new Guid("d3fc47f7-344c-494a-9564-3e5818a35e78"));

            migrationBuilder.DeleteData(
                table: "Users",
                keyColumn: "Id",
                keyValue: new Guid("2ee08a3e-7687-44ce-8983-a4629b9068c6"));

            migrationBuilder.DeleteData(
                table: "Users",
                keyColumn: "Id",
                keyValue: new Guid("3d086c08-38b7-469f-91a9-43c5bde157fd"));

            migrationBuilder.DeleteData(
                table: "Users",
                keyColumn: "Id",
                keyValue: new Guid("5ee8addd-756f-4e48-b43d-293356e86a4c"));

            migrationBuilder.DeleteData(
                table: "Users",
                keyColumn: "Id",
                keyValue: new Guid("f91e9650-9de9-4995-8dd3-f3a8802df89a"));

            migrationBuilder.RenameColumn(
                name: "DateOT",
                table: "OTRequests",
                newName: "ToDate");

            migrationBuilder.AddColumn<DateTime>(
                name: "FromDate",
                table: "OTRequests",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

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

        protected override void Down(MigrationBuilder migrationBuilder)
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

            migrationBuilder.DropColumn(
                name: "FromDate",
                table: "OTRequests");

            migrationBuilder.RenameColumn(
                name: "ToDate",
                table: "OTRequests",
                newName: "DateOT");

            migrationBuilder.InsertData(
                table: "Systems",
                columns: new[] { "Id", "Code", "CreatedAt", "CreatedBy", "DeletedAt", "DeletedBy", "IsDeleted", "Name", "UpdatedAt", "UpdatedBy" },
                values: new object[] { new Guid("d3fc47f7-344c-494a-9564-3e5818a35e78"), "T1", new DateTime(2021, 2, 27, 21, 18, 30, 124, DateTimeKind.Utc).AddTicks(1111), new Guid("00000000-0000-0000-0000-000000000000"), null, new Guid("00000000-0000-0000-0000-000000000000"), false, "Default System", new DateTime(2021, 2, 27, 21, 18, 30, 124, DateTimeKind.Utc).AddTicks(2459), new Guid("00000000-0000-0000-0000-000000000000") });

            migrationBuilder.InsertData(
                table: "Users",
                columns: new[] { "Id", "ActivatedAt", "ActivatedBy", "CreatedAt", "CreatedBy", "DeletedAt", "DeletedBy", "Email", "Fullname", "Gender", "IsActivated", "IsDeleted", "Password", "PhoneNumber", "Role", "SystemId", "UpdatedAt", "UpdatedBy", "Username" },
                values: new object[,]
                {
                    { new Guid("5ee8addd-756f-4e48-b43d-293356e86a4c"), null, new Guid("00000000-0000-0000-0000-000000000000"), new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new Guid("00000000-0000-0000-0000-000000000000"), null, new Guid("00000000-0000-0000-0000-000000000000"), null, "Admin", null, true, false, "21232f297a57a5a743894a0e4a801fc3", null, 9999, new Guid("00000000-0000-0000-0000-000000000000"), null, new Guid("00000000-0000-0000-0000-000000000000"), "admin" },
                    { new Guid("f91e9650-9de9-4995-8dd3-f3a8802df89a"), null, new Guid("00000000-0000-0000-0000-000000000000"), new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new Guid("00000000-0000-0000-0000-000000000000"), null, new Guid("00000000-0000-0000-0000-000000000000"), null, "Admin", null, true, false, "4297f44b13955235245b2497399d7a93", null, 3, new Guid("00000000-0000-0000-0000-000000000000"), null, new Guid("00000000-0000-0000-0000-000000000000"), "emp" },
                    { new Guid("3d086c08-38b7-469f-91a9-43c5bde157fd"), null, new Guid("00000000-0000-0000-0000-000000000000"), new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new Guid("00000000-0000-0000-0000-000000000000"), null, new Guid("00000000-0000-0000-0000-000000000000"), null, "Default Line Manager", null, true, false, "4297f44b13955235245b2497399d7a93", null, 2, new Guid("00000000-0000-0000-0000-000000000000"), null, new Guid("00000000-0000-0000-0000-000000000000"), "line" },
                    { new Guid("2ee08a3e-7687-44ce-8983-a4629b9068c6"), null, new Guid("00000000-0000-0000-0000-000000000000"), new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new Guid("00000000-0000-0000-0000-000000000000"), null, new Guid("00000000-0000-0000-0000-000000000000"), null, "Default Project Manager", null, true, false, "4297f44b13955235245b2497399d7a93", null, 1, new Guid("00000000-0000-0000-0000-000000000000"), null, new Guid("00000000-0000-0000-0000-000000000000"), "proj" }
                });
        }
    }
}
