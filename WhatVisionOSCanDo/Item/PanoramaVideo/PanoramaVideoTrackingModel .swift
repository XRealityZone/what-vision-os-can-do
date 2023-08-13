//
// WhatVisionOSCanDo
// Created by: onee on 2023/8/13
//

import ARKit
import Foundation
import RealityKit
import AVFoundation
import RealityKitContent

let DEFAULT_VIDEO_URL = Bundle.main.url(forResource: "sample", withExtension: "mp4")!

struct PanoramaVideoModel {
    let rootEntity = Entity()
    let avPlayer = AVPlayer()

    func setup(url: URL = DEFAULT_VIDEO_URL) {
        let asset = AVAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        avPlayer.replaceCurrentItem(with: playerItem)
        
        let material = VideoMaterial(avPlayer: avPlayer)

        let sphere = try! Entity.load(named: "Scenes/PanoramaVideo", in: realityKitContentBundle)
        sphere.scale = .init(x: 1E3, y: 1E3, z: 1E3)

        let modelEntity = sphere.children[0].children[0] as! ModelEntity
        modelEntity.model?.materials = [material]

        rootEntity.addChild(sphere)
        rootEntity.scale *= .init(x: -1, y: 1, z: 1)
    }

    func play() {
        avPlayer.play()
    }

    func pause() {
        avPlayer.pause()
    }
}
