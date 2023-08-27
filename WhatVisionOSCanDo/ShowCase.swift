//
//  ShowCase.swift
//  WhatVisionOSCanDo
//
//  Created by onee on 2023/8/9.
//

import Foundation
import SwiftUI

enum ShowCase: String, Identifiable, CaseIterable, Equatable {
    case PanoramaVideo, WorldReconstruction, PlaneClassification, SharePlay, HandTracking, TargetPlane, Gesture

    var id: Self { self }
    var name: String { rawValue }

    var detail: String {
        switch self {
            case .PanoramaVideo: "Show Panorama Video in visionOS"
            case .WorldReconstruction: "Use ARKit to scene the world"
            case .PlaneClassification: "Use ARKit to classification the plane"
            case .SharePlay: "Show the SharePlay in visionOS"
            case .HandTracking: "Tracking the hand movement"
            case .TargetPlane: "Place Entity onto target plane"
            case .Gesture: "Gesture in 3D"
        }
    }

    var windowDestination: AnyView? {
        switch self {
            case .PanoramaVideo: AnyView(VideoController())
            case .SharePlay: AnyView(PlayTogtherView())
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
        case .Gesture: "Gesture"
            default: nil
        }
    }

    var immersiveSpaceId: String? {
        switch self {
            case .WorldReconstruction: "WorldScening"
            case .PlaneClassification: "PalneClassification"
            case .HandTracking: "HandTracking"
            case .TargetPlane: "TargetPlane"
            default: nil
        }
    }
}
