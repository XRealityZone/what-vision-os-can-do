//
// WhatVisionOSCanDo
// Created by: onee on 2023/8/14
//

import ARKit
import Foundation
import RealityKit

extension HandAnchor.Chirality {
    var description: String {
        switch self {
        case .left: "left"
        case .right: "right"
        }
    }
}

class HandTrackingModel: TrackingModel {
    let handDataProvider = HandTrackingProvider()

    @MainActor func run() async {
        do {
            if HandTrackingProvider.isSupported {
                try await session.run([handDataProvider])
                for await update in handDataProvider.anchorUpdates {
                    switch update.event {
                    case .updated:
                        let anchor = update.anchor

                        // Publish updates only if the hand and the relevant joints are tracked.
                        guard anchor.isTracked, let handSkeleton = anchor.handSkeleton else { continue }
                        updateFingerEnity(idPrefix: anchor.chirality.description, rootTransform: anchor.originFromAnchorTransform, skeleton: handSkeleton)
                    default:
                        break
                    }
                }
            } else {
                let neutralPose = HandSkeleton.neutralPose
                updateFingerEnity(idPrefix: "neutral", rootTransform: simd_float4x4(), skeleton: neutralPose)
            }
        } catch {
            print("error is \(error)")
        }
    }

    func monitorSessionEvents() async {
        for await event in session.events {
            switch event {
            case .authorizationChanged(let type, let status):
                if type == .handTracking, status != .allowed {
                    // Stop the game, ask the user to grant hand tracking authorization again in Settings.
                }
            default:
                print("Session event \(event)")
            }
        }
    }

    // MARK: genreate mesh for hand

    func updateFingerEnity(idPrefix: String, rootTransform: simd_float4x4, skeleton: HandSkeleton) {
        for joint in skeleton.allJoints {
            let name = "\(idPrefix)-\(joint.name)"
            if let entity = rootEntity.findEntity(named: name) {
                if joint.isTracked {
                    entity.setTransformMatrix(rootTransform * joint.anchorFromJointTransform, relativeTo: nil)
                    entity.scale = simd_float3(repeating: 0.01)
                    entity.isEnabled = true
                } else {
                    entity.isEnabled = false
                }

            } else {
                guard joint.isTracked else { continue }
                let entity = ModelEntity(mesh: .generateSphere(radius: 1), materials: [SimpleMaterial(color: .red, isMetallic: false)])
                entity.name = name
                entity.setTransformMatrix(rootTransform * joint.anchorFromJointTransform, relativeTo: nil)
                entity.scale = simd_float3(repeating: 0.01)
                rootEntity.addChild(entity)
            }
        }
    }
}
