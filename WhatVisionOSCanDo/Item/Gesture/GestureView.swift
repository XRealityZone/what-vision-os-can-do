//
//  GestureView.swift
//  WhatVisionOSCanDo
//
//  Created by renyujie on 2023/8/25.
//

import RealityKit
import RealityKitContent
import SwiftUI

struct GestureView: View {
    var body: some View {
        VStack {
            Text("Hello World")
            RealityView { content in
                do {
                    let entity = try await Entity(named: "Scenes/Gesture", in: realityKitContentBundle)
                    content.add(entity)
                } catch {
                    print("load entity error, error is \(error)")
                }
            } update: { _ in
            }
            .gesture(MagnifyGesture().targetedToAnyEntity().onEnded({ action in
                print("MagnifyGesture ended")
            }))
            .gesture(TapGesture().targetedToAnyEntity().onEnded({ action in
                print("TapGesture ended")
            }))
            .gesture(RotateGesture().targetedToAnyEntity().onEnded({ action in
                print("RotateGesture ended")
            }))
            .gesture(LongPressGesture().targetedToAnyEntity().onEnded({ action in
                print("LongPressGesture ended")
            }))
            .gesture(DragGesture().targetedToAnyEntity().onEnded({ action in
                print("DragGesture ended")
            }))
        }
    }
}

#Preview {
    GestureView()
}
