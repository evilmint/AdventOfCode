//
//  main.swift
//  AoCDay1
//
//  Created by aleksander.lorenc on 01/12/2019.
//

import Foundation

func calculateFuel(mass: Float) -> Float {
    var fuel = floor(mass / 3) - 2
    if fuel > 0 {
        let newFuel = calculateFuel(mass: fuel)
        if newFuel > 0 {
            fuel += newFuel
        }
    }

    return fuel
}

let masses = loadFileContents(fileName: "input.txt").split(separator: "\n").map { Int($0)! }
let result = Int(masses.reduce(0) { $0 + calculateFuel(mass: Float($1))})

print(result)
