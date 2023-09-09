//
// WhatVisionOSCanDo
// Created by: onee on 2023/8/13
//

import RealityKit
import RealityKitContent
import SwiftUI

struct PanoramaVideoImmersiveView: View {
    var model = PanoramaVideoModel()
    @EnvironmentObject var immseriveModel: ImmersiveModel

    var body: some View {
        RealityView { content in
            model.setup()
            content.add(model.rootEntity)
        } update: { _ in
            if immseriveModel.isPlayVideo {
                model.play()
            } else {
                model.pause()
            }
        }
        .onDisappear {
            model.stop()
        }
    }
}

#Preview {
    PlaneClassificationImmersiveView()
}
