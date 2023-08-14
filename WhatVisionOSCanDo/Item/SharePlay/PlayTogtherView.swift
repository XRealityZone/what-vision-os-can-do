//
// WhatVisionOSCanDo
// Created by: onee on 2023/8/14
//

import SwiftUI

struct PlayTogtherView: View {
    @State var manager: PlayTogtherManager = PlayTogtherManager()
    
    var body: some View {
        TextField("Text to Sync", text: $manager.playInfo.name)
            .onChange(of: manager.playInfo.name) { oldValue, newValue in
                manager.send(message: newValue)
            }
        Button(action: {
            Task {
                await manager.prepareForThePlay(play: PlayInfo(name: "HelloWorld"))
            }
        }, label: {
            Text("Tap to begin share")
        })
    }
}

#Preview {
    PlayTogtherView()
}
