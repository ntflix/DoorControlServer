import Fluent

struct CreateAccessMethod: AsyncMigration {
  func prepare(on database: Database) async throws {
    try await database.schema("access_method")
      .id()
      .field("created_at", .datetime, .required)
      .field("user_id", .uuid, .required, .references("user", "id"))
      .field("access_code", .string)
      .create()
  }

  func revert(on database: Database) async throws {
    try await database.schema("access_method").delete()
  }
}
