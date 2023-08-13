//
// WhatVisionOSCanDo
// Created by: onee on 2023/8/13
//

import ARKit
import Foundation
import RealityKit

class PlaneClassificationTrackingModel: TrackingModel {
    let planeDataProvider = PlaneDetectionProvider(alignments: [.horizontal, .vertical])
    
    @MainActor func run(enableGeoMesh: Bool, enableMeshClassfication: Bool) async {
        var providers: [DataProvider] = []
        if PlaneDetectionProvider.isSupported {
            providers.append(planeDataProvider)
        }
        do {
            try await session.run(providers)
            for await sceneUpdate in planeDataProvider.anchorUpdates {
                // print classifications
                try await updatePlaneEntity(sceneUpdate.anchor)
            }
        } catch {
            print("error is \(error)")
        }
    }
    
    // MARK: Plane Classification
        
    @MainActor fileprivate func updatePlaneEntity(_ anchor: PlaneAnchor) async throws {
        let modelEntity = try await generatePlanelExtent(anchor)
        let textEntity = await generatePlaneText(anchor)
        if let anchorEntity = rootEntity.findEntity(named: "PlaneAnchor-\(anchor.id)") {
            anchorEntity.children.removeAll()
            anchorEntity.addChild(modelEntity)
            anchorEntity.addChild(textEntity)
        } else {
            let anchorEntity = AnchorEntity(world: anchor.transform)
            // NOTE: 需要翻转 -90 度
            anchorEntity.orientation = .init(angle: -.pi / 2, axis: .init(1, 0, 0))
            anchorEntity.addChild(modelEntity)
            anchorEntity.addChild(textEntity)
            anchorEntity.name = "PlaneAnchor-\(anchor.id)"
            rootEntity.addChild(anchorEntity)
        }
    }
        
    fileprivate func removePlaneEntity(_ anchor: PlaneAnchor) throws {
        if let anchorEntity = rootEntity.findEntity(named: "PlaneAnchor-\(anchor.id)") {
            anchorEntity.removeFromParent()
        }
    }
        
    @MainActor fileprivate func generatePlanelExtent(_ anchor: PlaneAnchor) async throws -> ModelEntity {
        // NOTE: extent in visionOS is on the geomerty object
        let extent = anchor.geometry.extent
        var material = PhysicallyBasedMaterial()
        material.baseColor = .init(tint: .blue)
        material.blending = .transparent(opacity: 0.4)
        let modelEntity = ModelEntity(mesh: .generatePlane(width: extent.width, height: extent.height), materials: [material])
        // NOTE: rotationOnYAxis is not avaliable on the visionOS
        // modelEntity.transform.rotation = .init(angle: extent.rotationOnYAxis, axis: .init(0, 1, 0))
        return modelEntity
    }
        
    @MainActor fileprivate func generatePlaneText(_ anchor: PlaneAnchor) async -> ModelEntity {
        let classificationString = anchor.classificationString
        let textModelEntity = ModelEntity(
            mesh: .generateText(classificationString),
            materials: [SimpleMaterial(color: .black, isMetallic: false)]
        )
        textModelEntity.scale = simd_float3(repeating: 0.005)
        // NOTE: no center in visioin
        // textModelEntity.position = simd_float3(anchor.center.x, anchor.center.y, 0.5)
        return textModelEntity
    }
}
