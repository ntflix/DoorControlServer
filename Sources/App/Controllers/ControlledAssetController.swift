import Fluent
import Vapor

struct ControlledAssetController: RouteCollection {
  func boot(routes: RoutesBuilder) throws {
    let controlledAssets = routes.grouped("controlledAssets")

    controlledAssets.get(use: self.index)
    controlledAssets.post(use: self.create)
    controlledAssets.group(":controlledAssetID") { controlledAsset in
      controlledAsset.delete(use: self.delete)
    }
  }

  @Sendable
  func index(req: Request) async throws -> [ControlledAssetDTO] {
    try await ControlledAsset.query(on: req.db).all().map { $0.toDTO() }
  }

  @Sendable
  func create(req: Request) async throws -> ControlledAssetDTO {
    let controlledAsset = try req.content.decode(ControlledAssetDTO.self).toModel()

    try await controlledAsset.save(on: req.db)
    return controlledAsset.toDTO()
  }

  @Sendable
  func delete(req: Request) async throws -> HTTPStatus {
    guard
      let controlledAsset = try await ControlledAsset.find(
        req.parameters.get("controlledAssetID"), on: req.db)
    else {
      throw Abort(.notFound)
    }

    try await controlledAsset.delete(on: req.db)
    return .noContent
  }
}
