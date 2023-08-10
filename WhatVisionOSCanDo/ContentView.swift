//
//  ContentView.swift
//  WhatVisionOSCanDo
//
//  Created by 我就是御姐我摊牌了 on 2023/8/8.
//

import RealityKit
import RealityKitContent
import SwiftUI

struct ContentView: View {
    @State private var selectedItemId: Item.ID?

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    @EnvironmentObject var immersiveModel: ImmersiveModel

    var body: some View {
        NavigationSplitView {
            List(Item.allCases, selection: $selectedItemId) { item in
                Text(item.name)
            }
            .navigationTitle("All Show Cases")
        } detail: {
            VStack {
                if let selectedItemId, let item = Item.allCases.first(where: { $0.id == selectedItemId.id }) {
                    Text(item.detail)
                    if let immseriveSpaceId = item.immersiveSpaceId {
                        Toggle("Show Immersive", isOn: $immersiveModel.isShowImmersive)
                            .onChange(of: immersiveModel.isShowImmersive) { wasShowing, isShowing in
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

#Preview {
    ContentView()
}
