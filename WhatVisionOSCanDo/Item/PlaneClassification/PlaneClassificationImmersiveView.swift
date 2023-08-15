//
// WhatVisionOSCanDo
// Created by: onee on 2023/8/13
//

import SwiftUI
import RealityKit
import RealityKitContent

struct PlaneClassificationImmersiveView: View {
    @State var model =  PlaneClassificationTrackingModel()
    
    var body: some View {
        RealityView { content in
            content.add(model.rootEntity)
        }
        .task {
            await model.run(
                enablePlaneClassification: true
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
