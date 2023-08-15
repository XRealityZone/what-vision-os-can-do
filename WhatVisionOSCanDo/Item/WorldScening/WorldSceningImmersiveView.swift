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
            content.add(model.rootEntity)
        }
        .task {
            await model.run(
                enableGeoMesh: true,
                enableMeshClassfication: true
            )
        }
        .onDisappear {
            model.stop()
        }
    }
}

#Preview {
    WorldSceningImmersiveView()
        .previewLayout(.sizeThatFits)
}
