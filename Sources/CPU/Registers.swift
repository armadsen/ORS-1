//
//  Registers.swift
//  ORS-1
//
//  Created by Andrew R Madsen on 2/4/19.
//  Copyright © 2019 Open Reel Software. All rights reserved.
//

import Foundation

enum Register: Int, CaseIterable {
    
    enum Err: Error {
        case unknownRegister
    }
    
    case pc = 0xf08
    case sp = 0xf09
    
    case r0 = 0xf00
    case r1 = 0xf01
    case r2 = 0xf02
    case r3 = 0xf03
    case r4 = 0xf04
    case r5 = 0xf05
    case r6 = 0xf06
    case r7 = 0xf07
    
    
    init(string: String) throws {
        switch string {
        case "pc": self = .pc
        case "sp": self = .sp
            
        case "r0": self = .r0
        case "r1": self = .r1
        case "r2": self = .r2
        case "r3": self = .r3
        case "r4": self = .r4
        case "r5": self = .r5
        case "r6": self = .r6
        case "r7": self = .r7
        default: throw Err.unknownRegister
        }
    }
    
    var name: String {
        switch self {
        case .pc: return "pc"
        case .sp: return "sp"
            
        case .r0: return "r0"
        case .r1: return "r1"
        case .r2: return "r2"
        case .r3: return "r3"
        case .r4: return "r4"
        case .r5: return "r5"
        case .r6: return "r6"
        case .r7: return "r7"
        }
    }
}

@objcMembers class Registers: NSObject {
    var pc: Int = 0 // Program Counter
    var sp: Int = 0 // Stack Pointer
    
    var r0: Int = 0 // General purpose register
    var r1: Int = 0 // General purpose register
    var r2: Int = 0 // General purpose register
    var r3: Int = 0 // General purpose register
    var r4: Int = 0 // General purpose register
    var r5: Int = 0 // General purpose register
    var r6: Int = 0 // General purpose register
    var r7: Int = 0 // General purpose register
    
    subscript(register: Register) -> Int {
        get {
            switch register {
            case .pc: return pc
            case .sp: return sp
                
            case .r0: return r0
            case .r1: return r1
            case .r2: return r2
            case .r3: return r3
            case .r4: return r4
            case .r5: return r5
            case .r6: return r6
            case .r7: return r7
            }
        }
        
        set {
            switch register {
            case .pc: pc = newValue
            case .sp: sp = newValue
                
            case .r0: r0 = newValue
            case .r1: r1 = newValue
            case .r2: r2 = newValue
            case .r3: r3 = newValue
            case .r4: r4 = newValue
            case .r5: r5 = newValue
            case .r6: r6 = newValue
            case .r7: r7 = newValue
            }
        }
    }
}
