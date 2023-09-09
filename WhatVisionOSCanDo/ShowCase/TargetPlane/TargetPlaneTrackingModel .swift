//
// WhatVisionOSCanDo
// Created by: onee on 2023/8/13
//

import ARKit
import Foundation
import RealityKit
import RealityKitContent

let ANCHOR_NAME = "iMacPlane"

class TargetPlaneTrackingModel: TrackingModel {
    let planeDataProvider = PlaneDetectionProvider(alignments: [.horizontal, .vertical])
    
    @MainActor func run() async {
        if let _ = rootEntity.findEntity(named: ANCHOR_NAME) {
            return
        }
        do {
            let anchorEntity = AnchorEntity(.plane(.horizontal, classification: .table, minimumBounds: simd_float2(x: 0.2, y: 0.2)))
            let modelEntity = try await Entity.init(named: "Scenes/TargetPlane", in: realityKitContentBundle)
            anchorEntity.addChild(modelEntity)
            anchorEntity.name = ANCHOR_NAME
            rootEntity.addChild(anchorEntity)
        } catch {
            print("error is \(error)")
        }
    }
}
