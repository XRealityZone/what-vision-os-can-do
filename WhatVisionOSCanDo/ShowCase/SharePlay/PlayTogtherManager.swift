//
// WhatVisionOSCanDo
// Created by: onee on 2023/8/14
//

import Foundation
import GroupActivities

class PlayTogtherManager {
    @Published var groupSession: GroupSession<PlayTogtherActivity>?
    @Published var playInfo: PlayInfo = PlayInfo()
    
    var messenger: GroupSessionMessenger?
    
    init() {
        Task {
            for await session in PlayTogtherActivity.sessions() {
                guard let systemCoordinator = await session.systemCoordinator else { continue }
                
                // TODO: find out what is the local mean
                let isLocal = systemCoordinator.localParticipantState.isSpatial
                
                var configuration = SystemCoordinator.Configuration()
                configuration.spatialTemplatePreference = .sideBySide
                systemCoordinator.configuration = configuration
                
                let messenger = GroupSessionMessenger(session: session)
                
                Task.detached { [weak self] in
                    for await (info, _) in messenger.messages(of: PlayInfo.self) {
                        self?.handle(info: info) // custom func to handle the received message. See below.
                    }
                }

                session.join()
                
                self.messenger = messenger
                self.groupSession = session
            }
        }
    }
    
    func handle(info: PlayInfo) {
        self.playInfo = info
    }
    
    func send(message: String) {
        Task {
            do {
                try await self.messenger?.send(PlayInfo(name: message))
            } catch {
                print("send message error \(error)")
            }
        }
    }
    
    func prepareForThePlay(play: PlayInfo) async {
        do {
            let activity = PlayTogtherActivity(playInfo: play)
            switch await activity.prepareForActivation() {
                case .activationPreferred:
                    print("success")
                    let result = try await activity.activate()
                    print("result is \(result)")
                case .activationDisabled:
                    print("disabled")
                case .cancelled:
                    print("cancelled")
                @unknown default:
                    print("unknow")
            }
        } catch {
            print("the activate error is \(error)")
        }
    }
}
