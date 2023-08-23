//
//  WhatVisionOSCanDoApp.swift
//  WhatVisionOSCanDo
//
//  Created by onee on 2023/8/8.
//

import ARKit
import RealityKit
import SwiftUI

@main
struct WhatVisionOSCanDoApp: App {
    @State var immersiveModel: ImmersiveModel = .init()

    var body: some SwiftUI.Scene {
        WindowGroup {
            Home()
                .environmentObject(immersiveModel)
                .handlesExternalEvents(
                    preferring: [PlayTogtherActivity.activityIdentifier],
                    allowing: [PlayTogtherActivity.activityIdentifier]
                )
        }

        ImmersiveSpace(id: "WorldScening") {
            WorldSceningImmersiveView()
        }

        ImmersiveSpace(id: "PalneClassification") {
            PlaneClassificationImmersiveView()
        }
        
        ImmersiveSpace(id: "HandTracking") {
            HandTrackingView()
        }
        
        ImmersiveSpace(id: "TargetPlane") {
            TargetPlaneImmersiveView()
        }

        ImmersiveSpace(id: "PanoramaVideo") {
            PanoramaVideoImmersiveView().environmentObject(immersiveModel)
        }.immersionStyle(selection: .constant(.full), in: .full)
    }
}
