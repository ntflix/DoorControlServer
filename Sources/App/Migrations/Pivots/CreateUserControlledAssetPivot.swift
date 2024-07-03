import Fluent

struct CreateUserControlledAssetPivot: AsyncMigration {
  func prepare(on database: Database) async throws {
    let accessStatusType: DatabaseSchema.DataType = try await database.enum(
      "access_status"
    )
    .read()

    try await database.schema("user+controlled_asset")
      .id()
      .field("created_at", .datetime, .required)
      .field("user_id", .uuid, .required, .references("user", "id"))
      .field("controlled_asset_id", .uuid, .required, .references("controlled_asset", "id"))
      .field("access_status", accessStatusType, .required)
      .unique(on: "user_id", "controlled_asset_id", "access_status")
      .create()
  }

  func revert(on database: Database) async throws {
    try await database.schema("stakeholder_relation").delete()
  }
}
