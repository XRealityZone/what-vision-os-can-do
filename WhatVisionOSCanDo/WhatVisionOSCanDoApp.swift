//
//  WhatVisionOSCanDoApp.swift
//  WhatVisionOSCanDo
//
//  Created by 我就是御姐我摊牌了 on 2023/8/8.
//

import SwiftUI

@main
struct WhatVisionOSCanDoApp: App {
    @State var immersiveModel: ImmersiveModel = ImmersiveModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(immersiveModel)
        }

        ImmersiveSpace(id: "WorldScening") {
            ImmersiveView()
        }
    }
}
