//
//  Instruction.swift
//  ORS-1
//
//  Created by Andrew R Madsen on 2/4/19.
//  Copyright © 2019 Open Reel Software. All rights reserved.
//

import Foundation

enum Instruction: Int {

    enum Err: Error {
        case unknownInstruction
    }

    // Load and store
    case lda = 0x10 // Load absolute e.g. lda r0 42 -> r0 = 42
    case ldr = 0x11 // Load relative, e.g. ldr r0 r1 -> r0 = mem[r1]
    case sta = 0x12 // Store absolute, e.g. sta r0 42 -> mem[r0] = 42
    case str = 0x13 // Store relative, e.g. str r0 r1 -> mem[r0] = r1

    // Arithmetic
    case ada = 0x20 // Add absolute, e.g. ada r0 42 -> r0 = r0 + 42
    case adr = 0x21 // Add relative, e.g. adr r0 r1 -> r0 = r0 + mem[r1]
    case sba = 0x22 // Subtract absolute, e.g. ada r0 42 -> r0 = r0 - 42
    case sbr = 0x23 // Subtract relative, e.g. adr r0 r1 -> r0 = r0 - mem[r1]

    // Logic
    case ana = 0x30 // AND absolute, e.g. ana r0 42 -> r0 = r0 & 42
    case anr = 0x31 // AND relative, e.g. anr r0 r1 -> r0 = r0 & r1
    case ora = 0x32 // OR absolute, e.g. ana r0 42 -> r0 = r0 | 42
    case orr = 0x33 // OR relative, e.g. anr r0 r1 -> r0 = r0 | r1
    case xra = 0x34 // XOR absolute, e.g. ana r0 42 -> r0 = r0 ^ 42
    case xrr = 0x35 // XOR relative, e.g. anr r0 r1 -> r0 = r0 ^ r1

    // Compare
    case cpa = 0x40 // Compare absolute, e.g. cpa r0 42 -> flags = r0 - 42
    case cpr = 0x41 // Compare relative, e.g. cpr r0 r1 -> flags = r0 - r1

    // Branch
    case jpa = 0x50 // Jump absolute, e.g. jpa 42 -> pc = 42
    case jpr = 0x51 // Jump relative, e.g. jpa r0 -> pc = r0
    case joc = 0x52 // Jump if carry is true, e.g. joc 42 -> if carry { pc += 42 }
    case jnc = 0x53 // Jump if carry is false, e.g. jcz 42 -> if !carry { pc += 42 }
    case joz = 0x54 // Jump if last result is zero, e.g. joz 42 -> if zero { pc += 42 }
    case jnz = 0x55 // Jump if last result not zero, e.g. jnz 42 -> if !zero { pc += 42 }
    case jon = 0x56 // Jump if last result negative, e.g. jon 42 -> if negative { pc += 42 }
    case jnn = 0x57 // Jump if last result not negative, e.g. jnz 42 -> if !negative { pc += 42 }

    // Flags
    case win = 0x60 // Write 1 to negative, e.g. win -> negative = true
    case won = 0x61 // Write 0 zero e.g. won -> negative = false
    case wic = 0x62 // Write 1 to carry, e.g. wic -> carry = true
    case woc = 0x63 // Write 0 to carry e.g. woc -> carry = false
    case wiz = 0x64 // Write 1 to zero, e.g. wiz -> zero = true
    case woz = 0x65 // Write 0 to zero e.g. woz -> zero = false

    // Convenience
    case prt = 0x70 // Print, e.g. prt r0 -> print(r0)

    init(mnemonic: String) throws {
        switch mnemonic {
        case "lda": self = .lda
        case "ldr": self = .ldr
        case "sta": self = .sta
        case "str": self = .str

        // Arithmetic
        case "ada": self = .ada
        case "adr": self = .adr
        case "sba": self = .sba
        case "sbr": self = .sbr

        // Logic
        case "ana": self = .ana
        case "anr": self = .anr
        case "ora": self = .ora
        case "orr": self = .orr
        case "xra": self = .xra
        case "xrr": self = .xrr

        // Compare
        case "cpa": self = .cpa
        case "cpr": self = .cpr

        // Branch
        case "jpa": self = .jpa
        case "jpr": self = .jpr
        case "joc": self = .joc
        case "jnc": self = .jnc
        case "joz": self = .joz
        case "jnz": self = .jnz
        case "jon": self = .jon
        case "jnn": self = .jnn

        // Flags
        case "win": self = .win
        case "won": self = .won
        case "wic": self = .wic
        case "woc": self = .woc
        case "wiz": self = .wiz
        case "woz": self = .woz

        // Convenience
        case "prt": self = .prt

        default: throw Err.unknownInstruction
        }
    }

    var isRelative: Bool {
        return rawValue <= Instruction.jpr.rawValue && rawValue % 2 != 0
    }
}
