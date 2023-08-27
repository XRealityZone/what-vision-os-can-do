//
//  ImmersiveModel.swift
//  WhatVisionOSCanDo
//
//  Created by onee on 2023/8/10.
//

import Foundation

class ImmersiveModel: ObservableObject {
    @Published var immersiveSpaceId: String? = nil
    @Published var windowId: String? = nil
    @Published var isPlayVideo: Bool = false
    @Published var navigationPath: [ShowCase] = []
}
