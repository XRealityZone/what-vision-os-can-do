//
// WhatVisionOSCanDo
// Created by: onee on 2023/8/13
//

import ARKit
import Foundation
import RealityKit

class TargetPlaneTrackingModel: TrackingModel {
    let planeDataProvider = PlaneDetectionProvider(alignments: [.horizontal, .vertical])
    
    @MainActor func run() async {
        let anchorEntity = AnchorEntity(.plane(.vertical, classification: .wall, minimumBounds: simd_float2(x: 0.5, y: 0.5)))
        let modelEntity = ModelEntity(mesh: .generateSphere(radius: 0.5), materials: [SimpleMaterial(color: .red, isMetallic: false)])
        anchorEntity.addChild(modelEntity)
        rootEntity.addChild(anchorEntity)
    }
}
