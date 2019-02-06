//
//  Flags.swift
//  ORS-1
//
//  Created by Andrew R Madsen on 2/4/19.
//  Copyright © 2019 Open Reel Software. All rights reserved.
//

import Foundation

@objcMembers class Flags: NSObject {

    dynamic var negative: Bool = false
    dynamic var carry: Bool = false
    dynamic var zero: Bool = false

    func reset() {
        for key in Flags.allKeys {
            self[keyPath: key] = false
        }
    }

    static let allKeys = [\Flags.negative, \Flags.carry, \Flags.zero]
}
