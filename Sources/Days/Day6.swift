//
//  Day6.swift
//  AoC2021
//
//  Created by Ryan Vidal on 12/6/21.
//

import Foundation

public let day6 = DailyPuzzleBase(solver: Day6Solver(),
                                       testInput: testInputString,
                                       puzzleInput: puzzleInputString)

public class Day6Solver: DailySolver {
    public typealias CalculationInput = [Int]

    public func ParseInput(_ input: String) -> CalculationInput {
        let inputLines = input.components(separatedBy: ",")
        return inputLines.compactMap(Int.init)
    }

    public func PerformPart1Calculation(_ input: CalculationInput) -> Int? {
        return input.reduce(0) { $0 + numberOfFish(after: 80, daysToDelay: $1) }
    }

    public func PerformPart2Calculation(_ input: CalculationInput) -> Int? {
        return input.reduce(0) { $0 + numberOfFish(after: 256, daysToDelay: $1) }
    }
}

fileprivate var cache: [Pair:Int] = [:]

private func numberOfFish(after numDays: Int, daysToDelay: Int) -> Int {
    if let cachedValue = cache[Pair(numDays, daysToDelay)] { return cachedValue }

    guard numDays >= daysToDelay else { return 1 }

    var finalCount = 1

    let spawns = (numDays - daysToDelay + 6) / 7

    for spawn in 0..<spawns {
        let daysLeftAfterSpawn = numDays - daysToDelay - spawn * 7
        finalCount += numberOfFish(after: daysLeftAfterSpawn, daysToDelay: 9)
    }

    cache[Pair(numDays, daysToDelay)] = finalCount

    return finalCount
}

// Naive approach:

//        var school = input
//        for _ in 1...80 {
//            var newLanternFish = [LanternFish]()
//            school.forEach { fish in
//                if let newFish = fish.shouldSpawn() {
//                    newLanternFish.append(newFish)
//                }
//            }
//            school.append(contentsOf: newLanternFish)
//        }
//
//        return school.count

//public class LanternFish {
//    static let gestationStart = 6
//
//    var spawnTimer: Int
//
//    init(_ initialTimer: Int = 8) {
//        self.spawnTimer = initialTimer
//    }
//
//    public func shouldSpawn() -> LanternFish? {
//        spawnTimer -= 1
//        if spawnTimer < 0 {
//            spawnTimer = LanternFish.gestationStart
//            return LanternFish()
//        }
//
//        return nil
//    }
//}

fileprivate let testInputString = """
3,4,3,1,2
"""

fileprivate let puzzleInputString = """
5,1,1,3,1,1,5,1,2,1,5,2,5,1,1,1,4,1,1,5,1,1,4,1,1,1,3,5,1,1,1,1,1,1,1,1,1,4,4,4,1,1,1,1,1,4,1,1,1,1,1,5,1,1,1,4,1,1,1,1,1,3,1,1,4,1,4,1,1,2,3,1,1,1,1,4,1,2,2,1,1,1,1,1,1,3,1,1,1,1,1,2,1,1,1,1,1,1,1,4,4,1,4,2,1,1,1,1,1,4,3,1,1,1,1,2,1,1,1,2,1,1,3,1,1,1,2,1,1,1,3,1,3,1,1,1,1,1,1,1,1,1,3,1,1,1,1,3,1,1,1,1,1,1,2,1,1,2,3,1,2,1,1,4,1,1,5,3,1,1,1,2,4,1,1,2,4,2,1,1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,4,3,1,2,1,2,1,5,1,2,1,1,5,1,1,1,1,1,1,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4,1,1,1,1,1,3,1,1,5,1,1,1,1,5,1,4,1,1,1,4,1,3,4,1,4,1,1,1,1,1,1,1,1,1,3,5,1,3,1,1,1,1,4,1,5,3,1,1,1,1,1,5,1,1,1,2,2
"""
