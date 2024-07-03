import Vapor

struct CardDTO: Content {
  var serial: String

  func toModel() -> Card {
    Card(serial: serial)
  }
}
