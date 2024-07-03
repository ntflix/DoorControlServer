import Vapor

enum ControlledAssetStatus: String, Content, Sendable, CaseIterable {
  case unlocked
  case faulty
  case disabled
}
