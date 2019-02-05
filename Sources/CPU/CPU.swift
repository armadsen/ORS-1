//
//  CPU.swift
//  ORS-1
//
//  Created by Andrew R Madsen on 2/4/19.
//  Copyright © 2019 Open Reel Software. All rights reserved.
//

import Foundation

class CPU {

    enum Err: Error {
        case badInstruction
    }

    func reset() {
        registers.reset()
    }

    func runUntilHalt() throws {
        reset()
        var shouldContinue = true
        while shouldContinue {
            shouldContinue = try execute(statement: program[registers.pc])
        }
    }

    func singleStep() throws {
        _ = try execute(statement: program[registers.pc])
    }

    // returns true if the program should continue
    func execute(statement: Statement) throws -> Bool {
        switch statement.instruction {
        // Load and store
        case .lda:
            guard statement.arguments.count == 2 else { throw Err.badInstruction }
            guard case let .register(destReg) = statement.arguments[0] else { throw Err.badInstruction }
            guard case let .absolute(value) = statement.arguments[1] else { throw Err.badInstruction }
            registers[destReg] = value
        case .ldr:
            guard statement.arguments.count == 2 else { throw Err.badInstruction }
            guard case let .register(destReg) = statement.arguments[0] else { throw Err.badInstruction }
            guard case let .register(srcReg) = statement.arguments[1] else { throw Err.badInstruction }
            registers[destReg] = memory[registers[srcReg]]
        case .sta:
            guard statement.arguments.count == 2 else { throw Err.badInstruction }
            guard case let .register(destReg) = statement.arguments[0] else { throw Err.badInstruction }
            guard case let .absolute(value) = statement.arguments[1] else { throw Err.badInstruction }
            memory[registers[destReg]] = value
        case .str:
            guard statement.arguments.count == 2 else { throw Err.badInstruction }
            guard case let .register(destReg) = statement.arguments[0] else { throw Err.badInstruction }
            guard case let .register(srcReg) = statement.arguments[1] else { throw Err.badInstruction }
            memory[registers[destReg]] = memory[registers[srcReg]]

        // Arithmetic
        case .ada:
            guard statement.arguments.count == 2 else { throw Err.badInstruction }
            guard case let .register(destReg) = statement.arguments[0] else { throw Err.badInstruction }
            guard case let .absolute(value) = statement.arguments[1] else { throw Err.badInstruction }
            registers[destReg] += value
        case .adr:
            guard statement.arguments.count == 2 else { throw Err.badInstruction }
            guard case let .register(destReg) = statement.arguments[0] else { throw Err.badInstruction }
            guard case let .register(srcReg) = statement.arguments[1] else { throw Err.badInstruction }
            registers[destReg] += registers[srcReg]
        case .sba:
            guard statement.arguments.count == 2 else { throw Err.badInstruction }
            guard case let .register(destReg) = statement.arguments[0] else { throw Err.badInstruction }
            guard case let .absolute(value) = statement.arguments[1] else { throw Err.badInstruction }
            registers[destReg] -= value
        case .sbr:
            guard statement.arguments.count == 2 else { throw Err.badInstruction }
            guard case let .register(destReg) = statement.arguments[0] else { throw Err.badInstruction }
            guard case let .register(srcReg) = statement.arguments[1] else { throw Err.badInstruction }
            registers[destReg] -= registers[srcReg]

        // Logic
        case .ana:
            guard statement.arguments.count == 2 else { throw Err.badInstruction }
            guard case let .register(destReg) = statement.arguments[0] else { throw Err.badInstruction }
            guard case let .absolute(value) = statement.arguments[1] else { throw Err.badInstruction }
            registers[destReg] &= value

        case .anr:
            guard statement.arguments.count == 2 else { throw Err.badInstruction }
            guard case let .register(destReg) = statement.arguments[0] else { throw Err.badInstruction }
            guard case let .register(srcReg) = statement.arguments[1] else { throw Err.badInstruction }
            registers[destReg] &= registers[srcReg]

        case .ora:
            guard statement.arguments.count == 2 else { throw Err.badInstruction }
            guard case let .register(destReg) = statement.arguments[0] else { throw Err.badInstruction }
            guard case let .absolute(value) = statement.arguments[1] else { throw Err.badInstruction }
            registers[destReg] |= value

        case .orr:
            guard statement.arguments.count == 2 else { throw Err.badInstruction }
            guard case let .register(destReg) = statement.arguments[0] else { throw Err.badInstruction }
            guard case let .register(srcReg) = statement.arguments[1] else { throw Err.badInstruction }
            registers[destReg] |= registers[srcReg]

        case .xra:
            guard statement.arguments.count == 2 else { throw Err.badInstruction }
            guard case let .register(destReg) = statement.arguments[0] else { throw Err.badInstruction }
            guard case let .absolute(value) = statement.arguments[1] else { throw Err.badInstruction }
            registers[destReg] ^= value

        case .xrr:
            guard statement.arguments.count == 2 else { throw Err.badInstruction }
            guard case let .register(destReg) = statement.arguments[0] else { throw Err.badInstruction }
            guard case let .register(srcReg) = statement.arguments[1] else { throw Err.badInstruction }
            registers[destReg] ^= registers[srcReg]


        // Compare
        case .cpa:
            guard statement.arguments.count == 2 else { throw Err.badInstruction }
            guard case let .register(destReg) = statement.arguments[0] else { throw Err.badInstruction }
            guard case let .absolute(value) = statement.arguments[1] else { throw Err.badInstruction }
            let comparison = registers[destReg] - value
            flags.negative = comparison < 0
            flags.carry = comparison >= 0
            flags.zero = comparison == 0
        case .cpr:
            guard statement.arguments.count == 2 else { throw Err.badInstruction }
            guard case let .register(destReg) = statement.arguments[0] else { throw Err.badInstruction }
            guard case let .register(srcReg) = statement.arguments[1] else { throw Err.badInstruction }
            let comparison = registers[destReg] - registers[srcReg]
            flags.negative = comparison < 0
            flags.carry = comparison >= 0
            flags.zero = comparison == 0

        // Branch
        case .jpa:
            guard statement.arguments.count == 1 else { throw Err.badInstruction }
            guard case let .absolute(value) = statement.arguments[0] else { throw Err.badInstruction }
            registers.pc = value
            return true
        case .jpr:
            guard statement.arguments.count == 1 else { throw Err.badInstruction }
            guard case let .register(srcReg) = statement.arguments[0] else { throw Err.badInstruction }
            registers.pc = registers[srcReg]
            return true
        case .joc:
            guard statement.arguments.count == 2 else { throw Err.badInstruction }
            guard case let .absolute(value) = statement.arguments[0] else { throw Err.badInstruction }
            if flags.carry {
                registers.pc = value
                return true
            }
        case .jnc:
            guard statement.arguments.count == 2 else { throw Err.badInstruction }
            guard case let .absolute(value) = statement.arguments[0] else { throw Err.badInstruction }
            if !flags.carry {
                registers.pc = value
                return true
            }
        case .joz:
            guard statement.arguments.count == 2 else { throw Err.badInstruction }
            guard case let .absolute(value) = statement.arguments[0] else { throw Err.badInstruction }
            if flags.zero {
                registers.pc = value
                return true
            }
        case .jnz:
            guard statement.arguments.count == 2 else { throw Err.badInstruction }
            guard case let .absolute(value) = statement.arguments[0] else { throw Err.badInstruction }
            if !flags.zero {
                registers.pc = value
                return true
            }
        case .jon:
            guard statement.arguments.count == 2 else { throw Err.badInstruction }
            guard case let .absolute(value) = statement.arguments[0] else { throw Err.badInstruction }
            if flags.negative {
                registers.pc = value
                return true
            }
        case .jnn:
            guard statement.arguments.count == 2 else { throw Err.badInstruction }
            guard case let .absolute(value) = statement.arguments[0] else { throw Err.badInstruction }
            if !flags.negative {
                registers.pc = value
                return true
            }

        // Flags
        case .win:
            guard statement.arguments.count == 0 else { throw Err.badInstruction }
            flags.negative = true
        case .won:
            guard statement.arguments.count == 0 else { throw Err.badInstruction }
            flags.negative = false
        case .wic:
            guard statement.arguments.count == 0 else { throw Err.badInstruction }
            flags.carry = true
        case .woc:
            guard statement.arguments.count == 0 else { throw Err.badInstruction }
            flags.carry = false
        case .wiz:
            guard statement.arguments.count == 0 else { throw Err.badInstruction }
            flags.zero = true
        case .woz:
            guard statement.arguments.count == 0 else { throw Err.badInstruction }
            flags.zero = false

        // Convenience
        case .prt:
            guard statement.arguments.count == 1 else { throw Err.badInstruction }
            guard case let .register(srcReg) = statement.arguments[0] else { throw Err.badInstruction }
            print(registers[srcReg])

            // Control

        case .hlt:
            return false

        }

        registers.pc += 1
        return true
    }

    var registers = Registers()
    private(set) var flags = Flags()

    var program: [Statement] = []
    var memory = [Int](repeating: 0, count: 1024)
}
