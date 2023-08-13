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
    @EnvironmentObject var immersiveModel: ImmersiveModel

    var body: some View {
        NavigationSplitView {
            List(Item.allCases, selection: $selectedItemId) { item in
                Text(item.name)
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
                                openWindow(id: windowId)
                            }, label: {
                                Text("Tap to goto window for the scene")
                            })
                        } else if let immseriveSpaceId = item.immersiveSpaceId {
                            Toggle("Show Immersive", isOn: $immersiveModel.isShowImmersive)
                                .onChange(of: immersiveModel.isShowImmersive) { wasShowing, _ in
                                    Task {
                                        if wasShowing {
                                            await dismissImmersiveSpace()
                                        } else {
                                            await openImmersiveSpace(id: immseriveSpaceId)
                                        }
                                    }
                                }
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
