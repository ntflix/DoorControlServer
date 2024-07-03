import Fluent

struct CreateCard: AsyncMigration {
  func prepare(on database: Database) async throws {
    try await database.schema("card")
      .id()
      .field("access_method_id", .uuid, .required, .references("access_method", "id"))
      .field("serial", .string)
      .create()
  }

  func revert(on database: Database) async throws {
    try await database.schema("access_method").delete()
  }
}
