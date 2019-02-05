//
//  Statement.swift
//  ORS-1
//
//  Created by Andrew R Madsen on 2/5/19.
//  Copyright © 2019 Open Reel Software. All rights reserved.
//

import Foundation

enum Argument {
    case absolute(Int)
    case register(Register)
}

struct Statement {

    enum Err: Error {
        case badStatement
    }

    init(instruction: Instruction, arguments: [Argument] = []) {
        self.instruction = instruction
        self.arguments = arguments
    }

    init(line: String) throws {
        let components = line.components(separatedBy: .whitespaces)
        let instruction = try Instruction(mnemonic: components[0])
        let args = try components.dropFirst().map { (string: String) -> Argument in
            if let num = Int(string) {
                return .absolute(num)
            } else if let reg = try? Register(string: string) {
                return .register(reg)
            }
            throw Err.badStatement
        }
        self.init(instruction: instruction, arguments: args)
    }

    var instruction: Instruction
    var arguments: [Argument] = []

    var rawValue: [Int] {
        var result = [instruction.rawValue]
        for arg in arguments {
            switch arg {
            case .absolute(let value):
                result.append(value)
            case .register(let register):
                result.append(register.rawValue)
            }
        }
        return result
    }

    var rawHexString: String {
        return rawValue.map({ String(format: "%02x", $0) }).joined()
    }
}
