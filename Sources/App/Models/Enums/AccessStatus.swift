import Vapor

enum AccessStatus: String, Content, Sendable, CaseIterable {
  case allow
  case deny
}
