import Fluent

import struct Foundation.UUID

final class ControlledAsset: Model, @unchecked Sendable {
  static let schema = "controlled_asset"

  @ID(key: .id)
  var id: UUID?

  @Field(key: "name")
  var name: String

  @Siblings(through: UserControlledAssetPivot.self, from: \.$controlledAsset, to: \.$user)
  var users: [User]

  @Enum(key: "status")
  var status: ControlledAssetStatus

  init() {}

  init(
    id: UUID? = nil,
    name: String,
    users: [User],
    status: ControlledAssetStatus
  ) {
    self.id = id
    self.name = name
    self.$users.value = users
    self.status = status
  }

  func toDTO() -> ControlledAssetDTO {
    .init(
      id: self.id,
      name: self.name,
      status: self.status
    )
  }
}
