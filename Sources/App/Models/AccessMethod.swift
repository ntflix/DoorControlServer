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
    card: Card? = nil,
    accessType: AccessStatus
  ) {
    self.id = id
    self.$user.id = user.id!
    if let card = card {
      self.card = card
      // do {
      //   self.card!.id = try card.requireID()
      // } catch {
      //   self.card = card
      // }
    }
    self.accessStatus = accessType
  }

  func toDTO() -> AccessMethodDTO {
    AccessMethodDTO(
      id: id,
      createdAt: createdAt,
      accessCode: accessCode,
      card: self.card?.toDTO(),
      accessStatus: accessStatus
    )
  }
}
