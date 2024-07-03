import Fluent

struct CreateAccessMethod: AsyncMigration {
  func prepare(on database: Database) async throws {
    let accessStatusType: DatabaseSchema.DataType = try await database.enum(
      "access_status"
    )
    .read()

    try await database.schema("access_method")
      .id()
      .field("created_at", .datetime, .required)
      .field("user_id", .uuid, .required, .references("user", "id"))
      .field("access_code", .string)
      .field(
        "access_status", accessStatusType, .required, .sql(.default(AccessStatus.allow.rawValue))
      )
      .create()
  }

  func revert(on database: Database) async throws {
    try await database.schema("access_method").delete()
  }
}
