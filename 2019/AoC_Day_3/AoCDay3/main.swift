//
//  main.swift
//  AoCDay1
//
//  Created by aleksander.lorenc on 01/12/2019.
//

import Foundation

let paths = loadFileContents(fileName: "input.txt")
    .split(separator: "\n")

var closestSteps = 999_999
let startPosition = (x: 0, y: 0)

struct Point: Hashable {
    let x, y: Int

    func manhattanDistance(to otherPoint: Point) -> Int {
        return abs(x - otherPoint.x) + abs(y - otherPoint.y)
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}

var pathMap: [Point: (visitedTimes: Int, stepCount: Int)] = [:]
var nextPathMap: [Point: (visitedTimes: Int, stepCount: Int)] = [:]

func makeKey(x: Int, y: Int) -> Point {
    return Point(x: x, y: y)
}

func drawPath(_ path: String) {
    nextPathMap = pathMap

    var currentPosition = (x: startPosition.x, y: startPosition.y)

    let steps = path.split(separator: ",")
    var stepCount = 1

    for step in steps {
        let direction = step[step.index(step.startIndex, offsetBy: 0)]
        let count = Int(step.dropFirst())!
        var moveVector = (x: 0, y: 0)

        switch String(direction) {
        case "L": moveVector = (x: -count, y: 0)
        case "D": moveVector = (x: 0, y: count)
        case "U": moveVector = (x: 0, y: -count)
        case "R": moveVector = (x: count, y: 0)
        default: break
        }

        for _ in 0 ..< abs(moveVector.x) + abs(moveVector.y) {
            currentPosition.y += (moveVector.y == 0 ? 0 : moveVector.y / abs(moveVector.y))
            currentPosition.x += (moveVector.x == 0 ? 0 : moveVector.x / abs(moveVector.x))

            let key = makeKey(x: currentPosition.x,
                              y: currentPosition.y)

            if (nextPathMap[key]?.visitedTimes ?? 0) == (pathMap[key]?.visitedTimes ?? 0) {
                let previousSteps = (nextPathMap[key]?.stepCount ?? 0)
                pathMap[key] = (visitedTimes: (pathMap[key]?.visitedTimes ?? 0) + 1,
                                stepCount: stepCount + previousSteps)
            }

            if (pathMap[key]?.visitedTimes ?? 0) > 1 {
                let steps = pathMap[key]?.stepCount ?? 0

                if steps < closestSteps {
                    closestSteps = steps
                }
            }

            stepCount += 1
        }
    }
}

for path in paths {
    drawPath(String(path))
}

print("Closest: \(closestSteps)")
