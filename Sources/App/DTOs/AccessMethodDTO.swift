import Vapor

struct AccessMethodDTO: Content {
  var id: UUID?
  var createdAt: Date?
  var accessCode: String?
  var card: CardDTO?
  var accessStatus: AccessStatus
}
