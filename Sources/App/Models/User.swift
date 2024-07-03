import Fluent

import struct Foundation.UUID

final class User: Model, @unchecked Sendable {
  static let schema = "user"

  @ID(key: .id)
  var id: UUID?

  @Field(key: "gocardless_id")
  var gocardlessId: String

  @Siblings(through: UserControlledAssetPivot.self, from: \.$user, to: \.$controlledAsset)
  var controlledAssets: [ControlledAsset]

  @Children(for: \.$user)
  var accessMethods: [AccessMethod]

  @Enum(key: "access_status")
  var accessStatus: AccessStatus

  init() {}

  init(
    id: UUID? = nil,
    gocardlessId: String,
    status: AccessStatus
  ) {
    self.id = id
    self.gocardlessId = gocardlessId
    self.accessStatus = status
  }

  func toDTO() -> UserDTO {
    .init(
      id: self.id,
      gocardlessId: self.gocardlessId,
      accessStatus: self.accessStatus
    )
  }
}
