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
            ContentView().environmentObject(immersiveModel)
        }

        ImmersiveSpace(id: "WorldScening") {
            WorldSceningImmersiveView()
        }
    }
}
