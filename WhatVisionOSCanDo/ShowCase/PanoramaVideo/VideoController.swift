//
// WhatVisionOSCanDo
// Created by: onee on 2023/8/13
//

import SwiftUI

struct VideoController: View {
    @EnvironmentObject var immseriveModel: ImmersiveModel
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                
                Button(action: {
                    immseriveModel.isPlayVideo.toggle()
                }, label: {
                    if immseriveModel.isPlayVideo {
                        Text("Tap to Stop")
                    } else {
                        Text("Tap to Play")
                    }
                })
                Spacer()
            }
            Spacer()
        }
        .task {
            if let _ = immseriveModel.immersiveSpaceId {
                await dismissImmersiveSpace()
            } else {
                await openImmersiveSpace(id: "PanoramaVideo")
                immseriveModel.immersiveSpaceId = "PanoramaVideo"
            }
        }
        .onDisappear() {
            Task {
                await dismissImmersiveSpace()
            }
        }
    }
}

#Preview {
    VideoController()
}
