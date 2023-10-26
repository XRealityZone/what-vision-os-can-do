//
//  GestureView.swift
//  WhatVisionOSCanDo
//
//  Created by renyujie on 2023/8/25.
//

import RealityKit
import RealityKitContent
import SwiftUI

enum GestureToggles {
    case null, tap, drag, longPress, magnify, rotate, rotate3D
}

struct GestureView: View {
    @State private var enabledGesture: GestureToggles = .tap
    @State private var isNight: Bool = true
    

    var body: some View {
        VStack {
            RealityView { content in
                do {
                    let entity = try await Entity(named: "Scenes/Gesture", in: realityKitContentBundle)
                    content.add(entity)
                } catch {
                    print("load entity error, error is \(error)")
                }
            } update: { content in
                let root = content.entities.first
                let moon = root?.findEntity(named: "Moon")
                let sun = root?.findEntity(named: "Sun")
                moon?.components[OpacityComponent.self]?.opacity = isNight ? 1.0 : 0.0
                sun?.components[OpacityComponent.self]?.opacity = isNight ? 0.0 : 1.0
            }
            .gesture(enabledGesture == .tap ? TapGesture().targetedToAnyEntity().onEnded { event in
                print("TapGesture ended")
                isNight = !isNight
            } : nil)
            .gesture(enabledGesture == .drag ? DragGesture().targetedToAnyEntity().onChanged { value in
                let location = value.convert(value.gestureValue.location3D, from: .global, to: value.entity.parent!)
                value.entity.setPosition(location, relativeTo: value.entity.parent)
            } : nil)
            .gesture(enabledGesture == .longPress ? LongPressGesture().targetedToAnyEntity().onEnded { _ in
                print("LongPressGesture ended")
            } : nil)
            .gesture(enabledGesture == .magnify ? MagnifyGesture().targetedToAnyEntity().onEnded { _ in
                print("MagnifyGesture ended")
            } : nil)
            .gesture(enabledGesture == .rotate ? RotateGesture().targetedToAnyEntity().onEnded { _ in
                print("RotateGesture ended")
            } : nil)
            .gesture(enabledGesture == .rotate3D ? RotateGesture3D(constrainedToAxis: .z).targetedToAnyEntity().onEnded { _ in
                print("RotateGesture3D ended")
            } : nil)
            HStack {
                Toggle("Tap", isOn: Binding(get: {
                    enabledGesture == .tap
                }, set: { value in
                    enabledGesture = value ? .tap : .null
                }))
                .toggleStyle(.button)
                Toggle("Drag", isOn: Binding(get: {
                    enabledGesture == .drag
                }, set: { value in
                    enabledGesture = value ? .drag : .null
                }))
                .toggleStyle(.button)
                Toggle("LongPress", isOn: Binding(get: {
                    enabledGesture == .longPress
                }, set: { value in
                    enabledGesture = value ? .longPress : .null
                }))
                .toggleStyle(.button)
                Toggle("Magnify", isOn: Binding(get: {
                    enabledGesture == .magnify
                }, set: { value in
                    enabledGesture = value ? .magnify : .null
                }))
                .toggleStyle(.button)
                Toggle("Rotate", isOn: Binding(get: {
                    enabledGesture == .rotate
                }, set: { value in
                    enabledGesture = value ? .rotate : .null
                }))
                .toggleStyle(.button)
                Toggle("Rotate3D", isOn: Binding(get: {
                    enabledGesture == .rotate3D
                }, set: { value in
                    enabledGesture = value ? .rotate3D : .null
                }))
                .toggleStyle(.button)
            }
        }
    }
}

#Preview {
    GestureView()
}
