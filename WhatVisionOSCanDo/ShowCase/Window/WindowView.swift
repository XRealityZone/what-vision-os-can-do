//
//  WindowView.swift
//  WhatVisionOSCanDo
//
//  Created by renyujie on 2024/2/6.
//

import SwiftUI

struct WindowView: View {
    var body: some View {
        Text("Hello World")
            .toolbar {
                ToolbarItem(placement: .bottomOrnament) {
                    Button("New", systemImage: "pencil") {
                        // new action
                    }
                }

                ToolbarItem(placement: .bottomOrnament) {
                    Button("Save", systemImage: "square.and.arrow.down") {
                        // save action
                    }
                }
            }
    }
}

#Preview {
    WindowView()
}
