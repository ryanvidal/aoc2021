//
//  DailyPuzzle.swift
//  AoC2021
//
//  Created by Ryan Vidal on 12/1/21.
//

import Foundation

public protocol DailyPuzzle {
    func SolvePart1Test() -> String
    func SolvePart2Test() -> String
    func SolvePart1() -> String
    func SolvePart2() -> String
}

public class DailyPuzzleBase<Solver: DailySolver>: DailyPuzzle {
    let solver: Solver
    let testInput: String
    let puzzleInput: String

    init(solver: Solver, testInput: String, puzzleInput: String) {
        self.solver = solver
        self.testInput = testInput
        self.puzzleInput = puzzleInput
    }

    public func SolvePart1Test() -> String {
        return Solve(testInput, calculation: solver.PerformPart1Calculation)
    }

    public func SolvePart2Test() -> String {
        return Solve(testInput, calculation: solver.PerformPart2Calculation)
    }

    public func SolvePart1() -> String {
        return Solve(puzzleInput, calculation: solver.PerformPart1Calculation)
    }

    public func SolvePart2() -> String {
        return Solve(puzzleInput, calculation: solver.PerformPart2Calculation)
    }

    private func Solve(_ input: String, calculation: (Solver.CalculationInput) -> Int?) -> String {
        let calculationInput = solver.ParseInput(input)
        let answer = calculation(calculationInput)

        guard let answer = answer else {
            return "No answer!"
        }

        return "\(answer)"
    }
}
