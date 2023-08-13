//
// WhatVisionOSCanDo
// Created by: onee on 2023/8/13
//

import SwiftUI
import RealityKit
import RealityKitContent

struct PanoramaVideoImmersiveView: View {
    var model =  PanoramaVideoModel()
    @EnvironmentObject var immseriveModel: ImmersiveModel
    
    var body: some View {
        RealityView { content in
            model.setup()
            content.add(model.rootEntity)
        } update: { content in
            if immseriveModel.isPlayVideo {
                model.play()
            } else {
                model.pause()
            }
        }
        .onAppear() {
            model.play()
        }
        .onDisappear() {
            model.pause()
        }
    }
}

#Preview {
    PlaneClassificationImmersiveView()
}
