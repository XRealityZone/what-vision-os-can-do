//
//  Item.swift
//  WhatVisionOSCanDo
//
//  Created by onee on 2023/8/9.
//

import Foundation
import SwiftUI

enum Item: String, Identifiable, CaseIterable, Equatable {
    case video, worldScening, planeClassification
    
    var id: Self { self }
    var name: String { rawValue.capitalized }

    var detail: String {
        switch self {
            case .video: "Show 3D Video in visionOS"
            case .worldScening: "Use ARKit to scene the world"
            case .planeClassification: "Use ARKit to classification the plane"
        }
    }
    
    var windowDestination: AnyView? {
        switch self {
            case .video: AnyView(VideoController())
            default: nil
        }
    }
    
    var windowId: String? {
        switch self {
            default: nil
        }
    }
    
    var immersiveSpaceId: String? {
        switch self {
            case .worldScening: "WorldScening"
            case .planeClassification: "PalneClassification"
            default: nil
        }
    }
}
