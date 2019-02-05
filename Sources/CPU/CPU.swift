//
//  CPU.swift
//  ORS-1
//
//  Created by Andrew R Madsen on 2/4/19.
//  Copyright © 2019 Open Reel Software. All rights reserved.
//

import Foundation

class CPU {
    var registers = Registers()

    var program: [Statement] = []
    var memory = [Int](repeating: 0, count: 1024)
}