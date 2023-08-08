//
//  WhatVisionOSCanDoApp.swift
//  WhatVisionOSCanDo
//
//  Created by 我就是御姐我摊牌了 on 2023/8/8.
//

import SwiftUI

@main
struct WhatVisionOSCanDoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
