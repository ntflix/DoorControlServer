import Fluent

struct CreateControlledAsset: AsyncMigration {
  func prepare(on database: Database) async throws {
    let controlledAssetStatusType: DatabaseSchema.DataType = try await database.enum(
      "controlled_asset_status"
    )
    .read()

    try await database.schema("controlled_asset")
      .id()
      .field("name", .string, .required)
      .field(
        "status", controlledAssetStatusType, .required,
        .sql(.default(ControlledAssetStatus.unlocked.rawValue))
      )
      .create()
  }

  func revert(on database: Database) async throws {
    try await database.schema("controlled_asset").delete()
  }
}
