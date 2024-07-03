import Fluent

import struct Foundation.Date
import struct Foundation.UUID

final class UserControlledAssetPivot: Model, @unchecked Sendable {
  static let schema = "user+controlled_asset"

  @ID(key: .id)
  var id: UUID?

  @Parent(key: "user_id")
  var user: User

  @Parent(key: "controlled_asset_id")
  var controlledAsset: ControlledAsset

  @Timestamp(key: "created_at", on: .create)
  var createdAt: Date?

  @Enum(key: "access_status")
  var accessStatus: AccessStatus

  init() {}

  init(
    user: User,
    controlledAsset: ControlledAsset,
    accessType: AccessStatus
  ) throws {
    self.$user.id = try user.requireID()
    self.$controlledAsset.id = try controlledAsset.requireID()
    self.accessStatus = accessType
  }
}
