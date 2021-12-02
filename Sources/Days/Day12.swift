//
//  Day12.swift
//  AoC2021
//
//  Created by Ryan Vidal on 12/12/21.
//

import Foundation

public let day12 = DailyPuzzleBase(solver: Day12Solver(),
                                       testInput: testInputString,
                                       puzzleInput: puzzleInputString)

public class Day12Solver: DailySolver {
    public typealias CalculationInput = [Int]

    public func ParseInput(_ input: String) -> CalculationInput {
        let inputLines = input.components(separatedBy: "\n")
        return inputLines.compactMap { Int($0) }
    }

    public func PerformPart1Calculation(_ input: CalculationInput) -> Double? {
        
        // Part 1 calculation here

        return nil
    }

    public func PerformPart2Calculation(_ input: CalculationInput) -> Double? {
        
        // Part 2 calculation here

        return nil
    }
}

fileprivate let testInputString = """
"""

fileprivate let puzzleInputString = """
"""
