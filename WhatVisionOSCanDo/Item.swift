//
//  Item.swift
//  WhatVisionOSCanDo
//
//  Created by onee on 2023/8/9.
//

import Foundation
import SwiftUI

enum Item: String, Identifiable, CaseIterable, Equatable {
    case video, worldScening, planeClassification, sharePlay, handTracking, targetPlane, gesture

    var id: Self { self }
    var name: String { rawValue.capitalized }

    var detail: String {
        switch self {
            case .video: "Show 3D Video in visionOS"
            case .worldScening: "Use ARKit to scene the world"
            case .planeClassification: "Use ARKit to classification the plane"
            case .sharePlay: "Show the SharePlay in visionOS"
            case .handTracking: "Tracking the hand movement"
            case .targetPlane: "Place Entity onto target plane"
            case .gesture: "Gesture in 3D"
        }
    }

    var windowDestination: AnyView? {
        switch self {
            case .video: AnyView(VideoController())
            case .sharePlay: AnyView(PlayTogtherView())
            default: nil
        }
    }

    var windowId: String? {
        switch self {
            default: nil
        }
    }

    var volumeId: String? {
        switch self {
        case .gesture: "Gesture"
            default: nil
        }
    }

    var immersiveSpaceId: String? {
        switch self {
            case .worldScening: "WorldScening"
            case .planeClassification: "PalneClassification"
            case .handTracking: "HandTracking"
            case .targetPlane: "TargetPlane"
            default: nil
        }
    }
}
