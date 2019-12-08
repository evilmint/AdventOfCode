//
//  main.swift
//  AoCDay1
//
//  Created by aleksander.lorenc on 01/12/2019.
//

import Foundation

class Solution {
    let min = 171_309
    let max = 643_603

    func part1() {
        var validPasswordCount = 0

        for i in min ... max {
            if validPassword(i) {
                validPasswordCount += 1
            }
        }

        print(validPasswordCount)
    }

    func part2() {
        var validPasswordCount = 0

        for i in min ... max {
            if validPasswordPart2(i) {
                validPasswordCount += 1
            }
        }

        print(validPasswordCount)
    }

    func hasTwoSameAdjacentDigits(number: Int) -> Bool {
        let stringified = String(number)

        for i in 0 ..< stringified.count - 1 {
            if stringified.charAt(i) == stringified.charAt(i + 1) {
                return true
            }
        }

        return false
    }

    func hasTwoSameAdjacentDigitsPart2(number: Int) -> Bool {
        let stringified = String(number)

        var i = 0
        while i < stringified.count - 1 {
            let repeatCount = getRepeatCount(string: stringified, offset: i)

            if repeatCount == 2 {
                return true
            }
            i += repeatCount
        }

        return false
    }

    private func getRepeatCount(string: String, offset: Int) -> Int {
        var repeatCount = 1
        let initialCharacter = string.charAt(offset)
        var index = offset
        while index < string.count - 1 {
            if string.charAt(index + 1) == initialCharacter {
                repeatCount += 1
                index += 1
            } else {
                break
            }
        }

        return repeatCount
    }

    private func doesNotHaveDecreasingDigits(number: Int) -> Bool {
        let stringified = String(number)

        for i in 0 ..< stringified.count - 1 {
            if Int(stringified.charAt(i))! > Int(stringified.charAt(i + 1))! {
                return false
            }
        }

        return true
    }

    private func doesNotHaveMultipleDigits(number: Int) -> Bool {
        let stringified = String(number)

        for i in 0 ..< stringified.count - 2 {
            if stringified.charAt(i) == stringified.charAt(i + 1) &&
                stringified.charAt(i + 1) == stringified.charAt(i + 2) {
                return false
            }
        }

        return true
    }

    private func validPassword(_ password: Int) -> Bool {
        return hasTwoSameAdjacentDigits(number: password) &&
            doesNotHaveDecreasingDigits(number: password)
    }

    private func validPasswordPart2(_ password: Int) -> Bool {
        return hasTwoSameAdjacentDigitsPart2(number: password) &&
            doesNotHaveDecreasingDigits(number: password)
    }
}

private extension String {
    func charAt(_ searchIndex: Int) -> String {
        return String(self[self.index(startIndex, offsetBy: searchIndex)])
    }
}

Solution().part1()
Solution().part2()
