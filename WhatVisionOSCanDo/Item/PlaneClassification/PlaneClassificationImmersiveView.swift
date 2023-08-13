//
// WhatVisionOSCanDo
// Created by: onee on 2023/8/13
//

import SwiftUI
import RealityKit

struct PlaneClassificationImmersiveView: View {
    @State var model = 
    
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
                enableMeshClassfication: true
            )
        }
        .onDisappear {
            model.stop()
        }
    }
}

#Preview {
    PlaneClassificationImmersiveView()
}
