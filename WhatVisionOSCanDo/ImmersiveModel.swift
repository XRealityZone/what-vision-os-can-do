//
//  ImmersiveModel.swift
//  WhatVisionOSCanDo
//
//  Created by onee on 2023/8/10.
//

import Foundation

class ImmersiveModel: ObservableObject {
    @Published var isShowImmersive: Bool = false
    @Published var isShowWidow: Bool = false
    @Published var isPlayVideo: Bool = false
    @Published var navigationPath: [Item] = []
}
