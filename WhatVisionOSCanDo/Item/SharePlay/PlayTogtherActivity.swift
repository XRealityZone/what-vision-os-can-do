//
// WhatVisionOSCanDo
// Created by: onee on 2023/8/14
//

import Foundation
import GroupActivities

struct PlayInfo: Codable {
    var name: String = ""
}

struct PlayTogtherActivity: GroupActivity {
    static let activityIdentifier: String = "zone.xreality.WhatVisionOSCanDo"
    
    let playInfo: PlayInfo

    var metadata: GroupActivityMetadata {
        var metadata = GroupActivityMetadata()
        metadata.type = .generic
        metadata.title = "Let's have fun"
        metadata.fallbackURL = URL(string: "https://xreality.zone")
        return metadata
    }
}
