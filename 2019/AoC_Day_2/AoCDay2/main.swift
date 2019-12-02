//
//  main.swift
//  AoCDay1
//
//  Created by aleksander.lorenc on 01/12/2019.
//

import Foundation

typealias Verb = Int
typealias Noun = Int

class Memory {
    var instructions: [Int]

    init(instructions: [Int]) {
        self.instructions = instructions
    }

    func setNoun(_ noun: Noun) {
        self.instructions[1] = noun
    }

    func setVerb(_ verb: Verb) {
        self.instructions[2] = verb
    }

    func restoreTo1202ProgramAlarm() {
        self.instructions[1] = 12
        self.instructions[2] = 2
    }
}

enum OpCode: Int {
    case add = 1
    case multiply = 2
    case halt = 99
}

class Computer {
    private var memory: Memory

    var output: Int { memory.instructions[0] }

    init(memory: Memory) {
        self.memory = memory
    }

    func compute() {
        var instructionPointer = 0
        var isRunning = true

        while isRunning {
            let opcode = getNextOpcode(address: instructionPointer)

            switch opcode {
            case .add:
                add(address: instructionPointer)
            case .halt:
                isRunning = false
            case .multiply:
                multiply(address: instructionPointer)
            }

            instructionPointer += 4
        }
    }

    private func add(address: Int) {
        let augend = memory.instructions[memory.instructions[address + 1]]
        let addend = memory.instructions[memory.instructions[address + 2]]

        let output = augend + addend

        memory.instructions[memory.instructions[address + 3]] = output
    }

    private func multiply(address: Int) {
        let multiplier = memory.instructions[memory.instructions[address + 1]]
        let multiplicand = memory.instructions[memory.instructions[address + 2]]

        let output = multiplier * multiplicand

        memory.instructions[memory.instructions[address + 3]] = output
    }

    private func getNextOpcode(address: Int) -> OpCode {
        return OpCode(rawValue: memory.instructions[address])!
    }
}

let numbers = loadFileContents(fileName: "input.txt")
    .split(separator: ",")
    .map {
        Int($0.trimmingCharacters(in: CharacterSet.decimalDigits.inverted))!
    }

for noun in 0...99 {
    for verb in 0...99 {
        let memory = Memory(instructions: numbers)
        memory.restoreTo1202ProgramAlarm()
        memory.setNoun(noun)
        memory.setVerb(verb)

        let computer = Computer(memory: memory)
        computer.compute()

        if computer.output == 19_690_720 {
            print("Verb: \(verb) Noun: \(noun)")
        }
    }
}
