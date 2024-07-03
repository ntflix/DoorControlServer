import Fluent
import Vapor

struct UserDTO: Content {
    var id: UUID?
    var gocardlessId: String?
    var accessStatus: AccessStatus

    func toModel() -> User {
        let model = User()

        model.id = self.id
        if let gocardlessId = self.gocardlessId {
            model.gocardlessId = gocardlessId
        }
        model.accessStatus = self.accessStatus

        return model
    }
}
