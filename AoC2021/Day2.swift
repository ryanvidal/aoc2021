//
//  Day2.swift
//  AoC2021
//
//  Created by Ryan Vidal on 11/30/21.
//

import Foundation

public class Day2: DailyPuzzle {
    typealias CalculationInput = [Int]

    public func SolvePart1Test() -> String {
        return Solve(testInput, calculation: performPart1Calculation)
    }

    public func SolvePart2Test() -> String {
        return Solve(testInput, calculation: performPart2Calculation)
    }

    public func SolvePart1() -> String {
        return Solve(puzzleInput, calculation: performPart1Calculation)
    }

    public func SolvePart2() -> String {
        return Solve(puzzleInput, calculation: performPart2Calculation)
    }

    private func Solve(_ input: String, calculation: (CalculationInput) -> Double?) -> String {
        let calculationInput = parseInput(input)
        let answer = calculation(calculationInput)

        guard let answer = answer else {
            return "No answer!"
        }

        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.numberStyle = .decimal

        return "\(formatter.string(from: answer as NSNumber) ?? "No answer!")"
    }

    private func parseInput(_ input: String) -> CalculationInput {
        var numbers: [Int] = []

        // PARSING LOGIC HERE

        return numbers
    }

    private func performPart1Calculation(_ input: CalculationInput) -> Double? {
        // SOLUTION LOGIC HERE

        return nil
    }

    private func performPart2Calculation(_ input: CalculationInput) -> Double? {
        // SOLUTION LOGIC HERE

        return nil
    }

    private var testInput = """
"""

    private var alternateTestInput = """
"""

    private var puzzleInput = """
"""
}
