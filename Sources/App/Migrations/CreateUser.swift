import Fluent

struct CreateUser: AsyncMigration {
  func prepare(on database: Database) async throws {
    let accessStatusType: DatabaseSchema.DataType = try await database.enum(
      "access_status"
    )
    .read()

    try await database.schema("user")
      .id()
      .field("gocardless_id", .string, .required)
      .field(
        "access_status", accessStatusType, .required, .sql(.default(AccessStatus.allow.rawValue))
      )
      .create()
  }

  func revert(on database: Database) async throws {
    try await database.schema("user").delete()
  }
}
