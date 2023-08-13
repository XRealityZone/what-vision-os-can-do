//
//  TrackingModel.swift
//  WhatVisionOSCanDo
//
//  Created by onee on 2023/8/11.
//

import ARKit
import Foundation
import RealityKit
import ARKit

struct WorldSceningTrackingModel {
    let session = ARKitSession()
    var rootEntity = AnchorEntity(world: .zero)
    let planeDataProvider = PlaneDetectionProvider(alignments: [.horizontal, .vertical])
    let sceneDataProvider = SceneReconstructionProvider(modes: [.classification])
    
    
    @MainActor func run(enableGeoMesh: Bool, enablePlaneClassification: Bool, enableMeshClassfication: Bool) async {
        var providers: [DataProvider] = []
        if PlaneDetectionProvider.isSupported {
            providers.append(planeDataProvider)
        }
        if SceneReconstructionProvider.isSupported {
            providers.append(sceneDataProvider)
        }
        do {
            try await session.run(providers)
            for await sceneUpdate in planeDataProvider.anchorUpdates {
                // print classifications
                let classification = sceneUpdate.anchor.classification
            }
            for await sceneUpdate in sceneDataProvider.anchorUpdates {
                let anchor = sceneUpdate.anchor
                let geometry = anchor.geometry
                switch sceneUpdate.event {
                    case .added:
                        // print classifications
                        print("add anchor classification is \(String(describing: geometry.classifications))")
                        try await createMeshEntity(geometry, anchor)
                    case .updated:
                        print("update")
                        try await updateMeshEntity(geometry, anchor)
                    case .removed:
                        print("removed anchor classification is \(String(describing: geometry.classifications))")
                        try removeMeshEntity(geometry, anchor)
                }
            }
        } catch {
            print("error is \(error)")
        }
    }
    
    // MARK: Geometry Mesh
    
    @MainActor fileprivate  func createMeshEntity(_ geometry: MeshAnchor.Geometry, _ anchor: MeshAnchor) async throws  {
        let modelEntity = try await generateModelEntity(geometry: geometry)
        let anchorEntity = AnchorEntity(world: anchor.transform)
        anchorEntity.addChild(modelEntity)
        anchorEntity.name = "MeshAnchor-\(anchor.id)"
        rootEntity.addChild(anchorEntity)
    }
    
    @MainActor fileprivate func updateMeshEntity(_ geometry: MeshAnchor.Geometry, _ anchor: MeshAnchor) async throws {
        let modelEntity = try await generateModelEntity(geometry: geometry)
        if let anchorEntity = rootEntity.findEntity(named: "MeshAnchor-\(anchor.id)") {
            anchorEntity.children.removeAll()
            anchorEntity.addChild(modelEntity)
        }
    }
    
    fileprivate func removeMeshEntity(_ geometry: MeshAnchor.Geometry, _ anchor: MeshAnchor) throws {
        if let anchorEntity = rootEntity.findEntity(named: "MeshAnchor-\(anchor.id)") {
            anchorEntity.removeFromParent()
        }
    }
    
    // MARK: Helpers
    
    @MainActor fileprivate func generateModelEntity(geometry: MeshAnchor.Geometry) async throws -> ModelEntity {
        // generate mesh
        var desc = MeshDescriptor()
        let posValues = geometry.vertices.asSIMD3(ofType: Float.self)
        desc.positions = .init(posValues)
        let normalValues = geometry.normals.asSIMD3(ofType: Float.self)
        desc.normals = .init(normalValues)
        do {
            desc.primitives = .polygons(
                // 应该都是三角形，所以这里直接写 3
                (0..<geometry.faces.count).map { _ in UInt8(3) },
                (0..<geometry.faces.count * 3).map {
                    geometry.faces.buffer.contents()
                        .advanced(by: $0 * geometry.faces.bytesPerIndex)
                        .assumingMemoryBound(to: UInt32.self).pointee
                }
            )
        }
        let meshResource = try await MeshResource.generate(from: [desc])
        let material = SimpleMaterial(color: .red, isMetallic: false)
        let modelEntity = ModelEntity(mesh: meshResource, materials: [material])
        return modelEntity
    }
}
