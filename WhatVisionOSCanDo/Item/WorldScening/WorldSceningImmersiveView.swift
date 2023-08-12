//
//  ImmersiveView.swift
//  WhatVisionOSCanDo
//
//  Created by onee on 2023/8/8.
//

import ARKit
import RealityKit
import RealityKitContent
import SwiftUI

struct WorldSceningImmersiveView: View {
    let model = WorldSceningTrackingModel()

    var body: some View {
        RealityView { content in
            // Add the initial RealityKit content
            if let scene = try? await Entity(named: "Immersive", in: realityKitContentBundle) {
                content.add(scene)
            }
        }
        .task {
            await model.run(
                enableGeoMesh: true,
                enablePlaneClassification: true,
                enableMeshClassfication: true
            )
        }
    }
}

#Preview {
    WorldSceningImmersiveView()
        .previewLayout(.sizeThatFits)
}
