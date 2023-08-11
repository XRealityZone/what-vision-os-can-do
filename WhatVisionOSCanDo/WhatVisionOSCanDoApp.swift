//
//  WhatVisionOSCanDoApp.swift
//  WhatVisionOSCanDo
//
//  Created by onee on 2023/8/8.
//

import ARKit
import RealityKit
import SwiftUI

@main
struct WhatVisionOSCanDoApp: App {
    @State var immersiveModel: ImmersiveModel = .init()
    @State var session = ARKitSession()

    var body: some SwiftUI.Scene {
        WindowGroup {
            ContentView().environmentObject(immersiveModel)
        }

        ImmersiveSpace(id: "WorldScening") {
            ImmersiveView()
                .task {
                    var providers: [DataProvider] = []
                    let planeDataProvider = PlaneDetectionProvider(alignments: [.horizontal, .vertical])
                    let sceneDataProvider = SceneReconstructionProvider(modes: [.classification])
                    if PlaneDetectionProvider.isSupported {
                        providers.append(planeDataProvider)
                    }
                    if SceneReconstructionProvider.isSupported {
                        providers.append(sceneDataProvider)
                    }
                    do {
                        try await session.run([sceneDataProvider, planeDataProvider])
                        for await sceneUpdate in planeDataProvider.anchorUpdates {
                            // print classifications
                            let geometry = sceneUpdate.anchor.geometry
                        }
                        for await sceneUpdate in sceneDataProvider.anchorUpdates {
                            let geometry = sceneUpdate.anchor.geometry
                            switch sceneUpdate.event {
                                case .added:
                                    // print classifications
                                    print("add anchor classification is \(String(describing: geometry.classifications))")
                                    let geomerty = sceneUpdate.anchor.geometry
                                    var desc = MeshDescriptor()
                                    let posValues = geomerty.vertices.asSIMD3(ofType: Float.self)
                                    desc.positions = .init(posValues)
                                    let normalValues = geomerty.normals.asSIMD3(ofType: Float.self)
                                    desc.normals = .init(normalValues)
                                    // TODO: 找到生成 MeshDescriptor 的方法
//                                    do {
//                                        desc.primitives = .polygons(
//                                            (0..<geomerty.faces.count).map { _ in UInt8(geomerty.faces.indexCountPerPrimitive) },
//                                            (0..<geomerty.faces.count * geomerty.faces.indexCountPerPrimitive).map {
//                                                geomerty.faces.buffer.contents()
//                                                    .advanced(by: $0 * geomerty.faces.bytesPerIndex)
//                                                    .assumingMemoryBound(to: UInt32.self).pointee
//                                            }
//                                        )
//                                    }
                                case .updated:
                                    print("update")
                                case .removed:
                                    print("removed anchor classification is \(String(describing: geometry.classifications))")
                            }
                        }
                    } catch {
                        print("error is \(error)")
                    }
                }
        }
    }
}
