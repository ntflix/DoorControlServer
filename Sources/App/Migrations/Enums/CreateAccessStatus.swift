import Fluent

struct CreateAccessStatus: AsyncMigration {
  func prepare(on database: Database) async throws {
    let relationTypeBuilder: EnumBuilder = database.enum("access_status")
    for type: AccessStatus in AccessStatus.allCases {
      _ = relationTypeBuilder.case(type.rawValue)
    }
    try await _ = relationTypeBuilder.create()
  }

  func revert(on database: Database) async throws {
    try await database.enum("access_status").delete()
  }
}
