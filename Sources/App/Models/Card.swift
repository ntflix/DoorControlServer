import Fluent

import struct Foundation.UUID

final class Card: Model, @unchecked Sendable {
  static let schema = "card"

  @ID(key: .id)
  var id: UUID?

  @Parent(key: "access_method_id")
  var accessMethod: AccessMethod

  @Field(key: "serial")
  var serial: String

  init() {}

  init(id: UUID? = nil, serial: String) {
    self.id = id
    self.serial = serial
  }

  func toDTO() -> CardDTO {
    CardDTO(
      serial: serial
    )
  }
}
