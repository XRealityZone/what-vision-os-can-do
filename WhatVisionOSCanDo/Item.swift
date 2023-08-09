//
//  Item.swift
//  WhatVisionOSCanDo
//
//  Created by 我就是御姐我摊牌了 on 2023/8/9.
//

import Foundation
import SwiftUI

enum Item: String, Identifiable, CaseIterable, Equatable {
    case video
    
    var id: Self { self }
    var name: String { rawValue.capitalized }

    var detail: String {
        switch self {
            case .video: "Show 3D Video in visionOS"
        }
    }
    
    var contentView: AnyView {
        switch self {
            case .video: AnyView(Text("Video"))
        }
    }
}
