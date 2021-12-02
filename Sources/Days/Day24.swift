//
//  Day24.swift
//  AoC2021
//
//  Created by Ryan Vidal on 12/24/21.
//

import Foundation

public let day24 = DailyPuzzleBase(solver: Day24Solver(),
                                       testInput: testInputString,
                                       puzzleInput: puzzleInputString)

public class Day24Solver: DailySolver {
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
