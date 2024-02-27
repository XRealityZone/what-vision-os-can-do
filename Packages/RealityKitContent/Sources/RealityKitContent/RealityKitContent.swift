import Foundation

/// Bundle for the RealityKitContent project
public let realityKitContentBundle = Bundle.module

public func initRealityKitContent() {
    EarthComponent.registerComponent()
    MoonComponent.registerComponent()
    SunComponent.registerComponent()
}
