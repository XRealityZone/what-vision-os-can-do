//
// WhatVisionOSCanDo
// Created by: onee on 2023/8/13
//

import Foundation
import ARKit
import RealityKit

class TrackingModel: NSObject {
    let session = ARKitSession()
    var rootEntity = AnchorEntity(world: .zero)
    
    func stop() {
        session.stop()
    }
}
