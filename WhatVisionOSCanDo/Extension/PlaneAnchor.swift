//
// WhatARCanDo
// Created by: onee on 2023/8/13
//

import ARKit
import Foundation

extension PlaneAnchor {
    var classificationString: String {
        switch self.classification {
            case .unknown, .undetermined, .notAvailable:
                return "Unknow"
            case .wall:
                return "Wall"
            case .floor:
                return "Floor"
            case .ceiling:
                return "Celling"
            case .table:
                return "Table"
            case .seat:
                return "Table"
            case .window:
                return "Window"
            case .door:
                return "Door"
            @unknown default:
                return "Unknow"
        }
    }
}
