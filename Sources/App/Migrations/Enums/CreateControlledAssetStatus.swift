import Fluent

struct CreateControlledAssetStatus: AsyncMigration {
  func prepare(on database: Database) async throws {
    let relationTypeBuilder: EnumBuilder = database.enum("controlled_asset_status")
    for type: ControlledAssetStatus in ControlledAssetStatus.allCases {
      _ = relationTypeBuilder.case(type.rawValue)
    }
    try await _ = relationTypeBuilder.create()
  }

  func revert(on database: Database) async throws {
    try await database.enum("controlled_asset_status").delete()
  }
}
