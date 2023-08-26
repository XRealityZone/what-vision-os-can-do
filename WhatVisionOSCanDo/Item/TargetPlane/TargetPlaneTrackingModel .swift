//
// WhatVisionOSCanDo
// Created by: onee on 2023/8/13
//

import ARKit
import Foundation
import RealityKit
import RealityKitContent

class TargetPlaneTrackingModel: TrackingModel {
    let planeDataProvider = PlaneDetectionProvider(alignments: [.horizontal, .vertical])
    
    @MainActor func run() async {
        do {
            let anchorEntity = AnchorEntity(.plane(.horizontal, classification: .table, minimumBounds: simd_float2(x: 0.2, y: 0.2)))
            let modelEntity = try await Entity.init(named: "Scenes/TargetPlane", in: realityKitContentBundle)
            anchorEntity.addChild(modelEntity)
            rootEntity.addChild(anchorEntity)
        } catch {
            print("error is \(error)")
        }
    }
}
