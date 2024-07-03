import Fluent
import Vapor

extension UserController {
  @Sendable
  func getAccessMethods(req: Request) async throws -> [AccessMethodDTO] {
    guard let userID = req.parameters.get("userID", as: UUID.self) else {
      throw Abort(.badRequest)
    }

    let user = try await User.find(userID, on: req.db)
    guard let user = user else {
      throw Abort(.notFound)
    }

    return try await user.$accessMethods.query(on: req.db)
      .with(\.$card)
      .all()
      .map { $0.toDTO() }
  }

  @Sendable
  func createCard(req: Request) async throws -> CardDTO {
    guard let userID = req.parameters.get("userID", as: UUID.self) else {
      throw Abort(.badRequest)
    }

    let user = try await User.find(userID, on: req.db)
    guard let user = user else {
      throw Abort(.notFound)
    }

    let accessMethod = AccessMethod(
      user: user,
      accessType: .allow
    )
    try await accessMethod.save(on: req.db)

    let card: Card = try req.content.decode(CardDTO.self).toModel()
    if card.serial.isEmpty {
      throw Abort(.badRequest, reason: "Card serial cannot be empty")
    }

    card.$accessMethod.id = accessMethod.id!
    try await card.save(on: req.db)

    return card.toDTO()
  }

  @Sendable
  func createCode(req: Request) async throws -> AccessMethodDTO {
    throw Abort(.notImplemented)
    /*
    guard let userID = req.parameters.get("userID", as: UUID.self) else {
      throw Abort(.badRequest)
    }

    let user = try await User.find(userID, on: req.db)
    guard let user = user else {
      throw Abort(.notFound)
    }

    let accessMethod = try req.content.decode(AccessMethodDTO.self).toModel()
    try await accessMethod.save(on: req.db)

    return accessMethod.toDTO()
    */
  }
}
