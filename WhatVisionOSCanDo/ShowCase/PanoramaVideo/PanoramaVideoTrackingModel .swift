//
// WhatVisionOSCanDo
// Created by: onee on 2023/8/13
//

import ARKit
import AVFoundation
import Foundation
import RealityKit
import RealityKitContent

let DEFAULT_VIDEO_URL = Bundle.main.url(forResource: "sample", withExtension: "mp4")!
let RADIUS: Float = 1000

struct PanoramaVideoModel {
    let rootEntity = Entity()
    let avPlayer = AVPlayer()

    func setup(url: URL = DEFAULT_VIDEO_URL) {
        let asset = AVAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        avPlayer.replaceCurrentItem(with: playerItem)

        let material = VideoMaterial(avPlayer: avPlayer)

        let sphere = ModelEntity(mesh: .generateSphere(radius: RADIUS))
        sphere.model?.materials = [material]
        sphere.scale *= .init(x: -1, y: 1, z: 1)

        rootEntity.addChild(sphere)
    }

    func play() {
        avPlayer.play()
    }

    func pause() {
        avPlayer.pause()
    }

    func stop() {
        avPlayer.pause()
        avPlayer.seek(to: .zero)
    }
}
