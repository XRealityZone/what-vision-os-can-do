//
//  ContentView.swift
//  WhatVisionOSCanDo
//
//  Created by onee on 2023/8/8.
//

import RealityKit
import RealityKitContent
import SwiftUI

struct Home: View {
    @State private var selectedItemId: Item.ID?

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    @Environment(\.openWindow) var openWindow
    @Environment(\.dismissWindow) var dismissWindow
    @EnvironmentObject var immersiveModel: ImmersiveModel

    var body: some View {
        NavigationSplitView {
            List(Item.allCases, selection: $selectedItemId) { item in
                Text(item.name)
            }
            .onChange(of: selectedItemId) { _, _ in
                if let _ = immersiveModel.immersiveSpaceId {
                    Task {
                        immersiveModel.immersiveSpaceId = nil
                        await dismissImmersiveSpace()
                    }
                }
                if let id = immersiveModel.windowId {
                    immersiveModel.windowId = nil
                    dismissWindow(id: id)
                }
            }
            .navigationTitle("All Show Cases")
        } detail: {
            NavigationStack(path: $immersiveModel.navigationPath) {
                VStack {
                    if let selectedItemId, let item = Item.allCases.first(where: { $0.id == selectedItemId.id }) {
                        Text(item.detail)
                        if let destination = item.windowDestination {
                            NavigationLink(destination: {
                                destination
                            }, label: {
                                Text("Tap to goto window for the scene")
                            })
                        } else if let windowId = item.windowId {
                            Button(action: {
                                immersiveModel.windowId = windowId
                                openWindow(id: windowId)
                            }, label: {
                                Text("Tap to goto window for the scene")
                            })
                        } else if let volumeId = item.volumeId {
                            Button(action: {
                                immersiveModel.windowId = volumeId
                                openWindow(id: volumeId)
                            }, label: {
                                Text("Tap to goto volume for the scene")
                            })
                        } else if let immseriveSpaceId = item.immersiveSpaceId {
                            Toggle("Show Immersive", isOn: Binding(get: {
                                immersiveModel.immersiveSpaceId != nil
                            }, set: { value in
                                Task {
                                    if value {
                                        immersiveModel.immersiveSpaceId = immseriveSpaceId
                                        await openImmersiveSpace(id: immseriveSpaceId)
                                    } else {
                                        immersiveModel.immersiveSpaceId = nil
                                        await dismissImmersiveSpace()
                                    }
                                }
                            }))
                            .toggleStyle(.button)
                        }
                    } else {
                        Text("Please select an item")
                    }
                }
                .navigationTitle("Content")
                .padding()
            }
        }
    }
}

#Preview {
    Home()
}
