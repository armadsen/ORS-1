//
//  Assembler.swift
//  ORS-1
//
//  Created by Andrew R Madsen on 2/4/19.
//  Copyright © 2019 Open Reel Software. All rights reserved.
//

import Foundation

func assemble(string: String) throws -> [Statement] {
    let lines = string.components(separatedBy: .newlines)
    return try lines.map(Statement.init)
}
