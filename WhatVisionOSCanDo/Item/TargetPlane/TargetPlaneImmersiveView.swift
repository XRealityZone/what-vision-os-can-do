//
// WhatVisionOSCanDo
// Created by: onee on 2023/8/13
//

import RealityKit
import RealityKitContent
import SwiftUI

struct TargetPlaneImmersiveView: View {
    @State var model = TargetPlaneTrackingModel()

    var body: some View {
        RealityView { content in
            content.add(model.rootEntity)
        }
        .task {
            await model.run()
        }
        .onDisappear {
            model.stop()
        }
    }
}

#Preview {
    PlaneClassificationImmersiveView()
}
