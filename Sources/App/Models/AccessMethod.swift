import Fluent

import struct Foundation.Date
import struct Foundation.UUID

final class AccessMethod: Model, @unchecked Sendable {
  static let schema = "access_method"

  @ID(key: .id)
  var id: UUID?

  @Timestamp(key: "created_at", on: .create)
  var createdAt: Date?

  @Parent(key: "user_id")
  var user: User

  @OptionalChild(for: \.$accessMethod)
  var card: Card?

  @Field(key: "access_code")
  var accessCode: String?

  @Enum(key: "access_status")
  var accessStatus: AccessStatus

  init() {}

  init(
    id: UUID? = nil,
    user: User,
    card: Card?,
    accessType: AccessStatus
  ) {
    self.id = id
    self.$user.id = user.id!
    self.card = card
    self.accessStatus = accessType
  }
}
