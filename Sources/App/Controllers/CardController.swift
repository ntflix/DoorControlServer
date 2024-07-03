import Fluent
import Vapor

struct CardController: RouteCollection {
  func boot(routes: RoutesBuilder) throws {
    let cards = routes.grouped("cards")

    cards.get("bySerial", ":cardSerial", use: self.getByCardSerial)
  }

  @Sendable
  func getByCardSerial(req: Request) async throws -> Bool {
    guard let cardSerial = req.parameters.get("cardSerial") else {
      throw Abort(.badRequest)
    }

    // fetch where User.accessMethods contains a card with the given serial
    let matchingCard = try await Card.query(on: req.db)
      .filter(\.$serial == cardSerial)
      .join(
        AccessMethodAlias.self,
        on: \Card.$accessMethod.$id == \AccessMethodAlias.model.$id
      )
      .filter(
        AccessMethodAlias.self,
        \.$accessStatus == .allow
      )
      // and where User status is active
      .join(
        UserAlias.self,
        on: \UserAlias.model.$id == \AccessMethodAlias.model.$user.$id
      )
      .filter(
        UserAlias.self,
        \.$accessStatus == .allow
      )
      .first()

    return matchingCard != nil
  }
}

final class AccessMethodAlias: ModelAlias {
  static let name = "access_method"
  let model = AccessMethod()
}

final class UserAlias: ModelAlias {
  static let name = "user"
  let model = User()
}
