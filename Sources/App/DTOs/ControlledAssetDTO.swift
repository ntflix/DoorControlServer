import Fluent
import Vapor

struct ControlledAssetDTO: Content {
    var id: UUID?
    var name: String
    var status: ControlledAssetStatus

    func toModel() -> ControlledAsset {
        let model = ControlledAsset()

        model.id = self.id
        model.name = name
        model.status = self.status

        return model
    }
}
