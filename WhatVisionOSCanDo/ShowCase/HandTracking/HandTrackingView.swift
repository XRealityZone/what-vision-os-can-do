//
// WhatVisionOSCanDo
// Created by: onee on 2023/8/14
//

import SwiftUI
import RealityKit

struct HandTrackingView: View {
    @State var model = HandTrackingModel()
    
    var body: some View {
        RealityView { content in
            content.add(model.rootEntity)
        }
        .task {
            await model.run()
        }
        .task {
            await model.monitorSessionEvents()
        }
    }
}

#Preview {
    HandTrackingView()
}
