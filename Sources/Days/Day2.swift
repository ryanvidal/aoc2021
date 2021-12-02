//
//  Day2.swift
//  AoC2021
//
//  Created by Ryan Vidal on 12/2/21.
//

import Foundation

public let day2 = DailyPuzzleBase(solver: Day2Solver(),
                                  testInput: testInputString,
                                  puzzleInput: puzzleInputString)

public class Day2Solver: DailySolver {
    public typealias CalculationInput = [Move]

    public func ParseInput(_ input: String) -> CalculationInput {
        let inputLines = input.components(separatedBy: "\n")

        return inputLines.map(Move.init)
    }

    public func PerformPart1Calculation(_ input: CalculationInput) -> Double? {
        var (depth, horizontal) = (0.0, 0.0)

        for move in input {
            move.adjustPosition(depth: &depth, horizontal: &horizontal)
        }

        return depth * horizontal
    }

    public func PerformPart2Calculation(_ input: CalculationInput) -> Double? {
        var (depth, horizontal, aim) = (0.0, 0.0, 0.0)

        for move in input {
            move.adjustPosition(depth: &depth, horizontal: &horizontal, aim: &aim)
        }

        return depth * horizontal
    }
}

// MARK: - Move -
extension Day2Solver {
    public enum Move {
        case forward(x: Double)
        case down(x: Double)
        case up(x: Double)

        private func newDepth(_ initialDepth: Double) -> Double {
            switch self {
            case .forward:
                return initialDepth
            case .down(let x):
                return initialDepth + x
            case .up(let x):
                return initialDepth - x
            }
        }

        private func newDepth(_ initialDepth: Double, aim: Double) -> Double {
            switch self {
            case .forward(let x):
                return initialDepth + aim * x
            default:
                return initialDepth
            }
        }

        private func newHorizontal(_ initialHorizontal: Double) -> Double {
            switch self {
            case .forward(let x):
                return initialHorizontal + x
            default:
                return initialHorizontal
            }
        }

        private func newAim(_ initialAim: Double) -> Double {
            switch self {
            case .down(let x):
                return initialAim + x
            case .up(let x):
                return initialAim - x
            default:
                return initialAim
            }
        }

        public func adjustPosition(depth: inout Double, horizontal: inout Double) {
            // Ignore aim
            depth = newDepth(depth)
            horizontal = newHorizontal(horizontal)
        }

        public func adjustPosition(depth: inout Double, horizontal: inout Double, aim: inout Double) {
            aim = newAim(aim)
            depth = newDepth(depth, aim: aim)
            horizontal = newHorizontal(horizontal)
        }

        public init(instruction: String) {
            let instructionParts = instruction.components(separatedBy: " ")
            switch instructionParts[0] {
            case "forward":
                self = .forward(x: Double(instructionParts[1])!)
            case "down":
                self = .down(x: Double(instructionParts[1])!)
            case "up":
                self = .up(x: Double(instructionParts[1])!)
            default:
                fatalError()
            }
        }
    }
}

fileprivate let testInputString = """
forward 5
down 5
forward 8
up 3
down 8
forward 2
"""

fileprivate let puzzleInputString = """
forward 2
down 4
down 1
down 4
forward 3
down 6
down 5
forward 3
forward 8
down 2
down 3
up 8
down 5
up 7
down 7
forward 5
up 2
down 6
forward 7
forward 1
forward 2
forward 7
up 7
forward 6
down 3
down 1
up 9
down 2
up 1
down 1
up 6
forward 6
down 7
forward 6
up 1
down 6
forward 2
up 7
forward 4
forward 8
forward 7
down 7
forward 8
down 1
down 6
down 7
forward 4
down 3
up 7
down 5
down 9
up 8
up 4
down 2
down 3
up 7
forward 6
forward 6
forward 8
forward 2
up 5
down 8
down 3
down 3
down 4
down 9
down 6
up 6
forward 4
down 6
forward 3
forward 3
down 4
down 8
down 2
up 5
up 5
forward 3
forward 5
down 7
forward 6
forward 9
forward 8
forward 2
down 3
down 3
down 7
down 1
down 1
down 1
down 2
down 8
down 6
forward 6
up 1
up 6
down 7
down 1
forward 1
up 2
up 8
up 8
forward 2
down 1
down 8
down 7
down 1
forward 1
down 9
up 3
down 3
forward 2
down 3
up 6
down 2
forward 7
down 9
down 6
down 1
forward 6
down 4
down 1
down 3
forward 3
down 5
forward 9
down 5
down 7
up 8
forward 8
forward 8
down 6
down 1
forward 8
down 4
up 4
up 4
up 2
forward 2
forward 2
down 1
up 8
down 1
down 7
forward 5
down 9
down 2
up 3
down 1
down 5
forward 6
down 7
up 3
forward 7
down 4
down 3
forward 4
up 8
down 4
forward 4
forward 2
forward 5
down 5
up 2
forward 4
down 4
forward 6
down 4
forward 1
down 5
forward 2
forward 2
down 8
forward 4
forward 7
down 3
up 3
forward 2
forward 6
forward 8
down 2
forward 4
down 2
up 9
down 9
down 2
forward 5
up 4
forward 2
down 2
down 3
forward 1
down 2
forward 8
forward 8
down 4
forward 6
down 3
down 3
down 5
forward 8
forward 4
forward 1
up 4
up 2
forward 8
down 8
forward 2
forward 6
up 1
up 5
forward 2
forward 4
forward 7
forward 8
forward 2
down 3
down 1
down 9
down 6
up 5
up 6
forward 6
down 3
down 2
down 1
forward 5
forward 2
forward 7
down 8
down 7
forward 7
up 8
forward 7
down 1
up 4
forward 9
forward 4
forward 1
down 3
down 9
down 7
forward 1
down 3
forward 3
down 4
down 7
forward 4
up 6
down 8
up 1
forward 6
forward 1
down 7
down 8
up 9
up 4
down 3
down 7
forward 8
up 2
up 6
forward 8
down 1
up 4
up 4
forward 8
down 2
down 4
down 3
forward 5
down 8
forward 1
down 2
forward 9
forward 3
up 6
down 6
forward 6
forward 4
down 6
down 3
down 3
forward 6
down 5
up 4
down 9
down 3
down 6
up 9
forward 6
down 2
forward 7
up 8
down 3
down 7
down 9
forward 6
down 1
forward 2
down 1
down 3
down 3
forward 5
forward 2
up 5
forward 4
up 7
down 9
forward 7
forward 3
down 6
forward 1
down 1
up 8
down 9
up 3
down 7
up 9
forward 7
down 7
down 9
forward 9
forward 7
up 9
down 7
down 2
down 7
up 2
down 3
down 9
down 6
forward 7
forward 8
forward 8
forward 6
forward 9
forward 4
down 4
down 5
down 7
forward 6
forward 2
forward 4
forward 9
down 4
forward 6
down 7
up 1
down 7
forward 9
forward 7
down 4
down 3
up 6
forward 8
forward 7
down 8
forward 4
up 6
up 4
forward 9
forward 4
forward 4
forward 7
down 1
up 6
forward 8
forward 3
up 6
forward 4
down 1
up 2
forward 1
down 5
forward 5
up 4
down 6
down 3
up 8
forward 9
down 2
forward 4
forward 8
down 9
forward 5
forward 2
down 9
down 8
forward 8
down 7
up 6
forward 1
up 9
up 3
forward 9
down 6
forward 9
down 3
down 3
forward 7
forward 5
down 8
down 9
down 3
down 6
up 8
down 9
forward 8
down 7
down 5
down 1
up 4
down 9
forward 6
forward 9
up 6
up 4
forward 3
forward 2
forward 1
down 1
down 2
forward 8
up 6
forward 5
up 4
down 1
forward 5
down 3
down 6
up 7
forward 2
forward 6
forward 7
forward 4
down 5
down 4
forward 4
down 6
up 2
up 2
forward 7
forward 3
down 8
down 1
down 8
forward 7
forward 7
up 5
forward 4
up 8
down 9
down 4
down 4
forward 5
down 1
forward 2
down 6
up 4
down 8
down 1
down 9
down 5
up 5
forward 4
down 2
down 8
down 4
forward 4
forward 5
down 8
up 9
forward 7
forward 6
down 8
down 3
up 7
down 7
forward 2
forward 5
forward 7
down 9
up 1
down 6
down 2
forward 6
forward 3
forward 3
up 9
forward 4
down 5
down 7
forward 8
forward 6
forward 5
down 9
down 5
down 1
down 7
forward 9
forward 8
down 2
down 4
down 1
up 5
up 5
forward 5
down 3
down 1
forward 8
up 9
up 3
down 3
up 3
up 5
forward 8
down 3
up 3
down 9
up 6
up 8
forward 5
up 2
down 6
forward 3
down 2
down 4
forward 9
forward 6
forward 3
up 5
down 9
down 7
forward 9
forward 7
forward 5
up 5
up 1
down 6
forward 4
forward 4
down 7
down 1
up 3
forward 6
forward 4
down 1
forward 5
forward 3
forward 1
forward 3
up 3
up 9
down 7
down 4
forward 8
down 8
down 3
up 2
down 8
forward 5
down 7
forward 6
down 9
up 5
forward 4
down 2
forward 6
down 8
down 7
forward 8
forward 5
down 2
forward 7
forward 5
forward 7
down 8
forward 5
down 8
down 6
down 7
down 9
forward 9
down 6
forward 8
up 6
up 1
down 5
forward 1
forward 7
up 2
up 5
up 6
down 5
down 5
forward 7
down 9
down 2
forward 9
forward 3
down 5
up 2
up 8
forward 5
forward 8
up 1
forward 3
forward 1
up 4
forward 1
down 9
down 6
forward 1
down 4
down 4
forward 9
down 3
up 6
down 3
forward 6
forward 6
down 3
forward 6
down 3
down 1
forward 3
down 7
up 9
forward 1
down 7
down 2
up 8
down 1
down 9
down 1
down 4
down 6
down 3
down 7
down 2
down 9
down 2
forward 4
up 3
down 4
up 4
down 1
forward 5
forward 7
down 7
forward 9
forward 6
down 8
forward 6
forward 7
up 3
down 3
up 6
forward 7
up 4
forward 4
down 1
up 8
forward 7
down 2
up 6
forward 1
forward 3
up 9
up 8
up 5
forward 7
up 5
down 6
forward 7
forward 7
down 4
down 3
forward 2
down 8
up 9
up 6
forward 7
forward 5
down 9
down 2
up 5
down 3
down 3
up 5
down 8
forward 7
down 4
down 2
up 9
down 5
down 8
down 5
down 6
forward 9
down 3
down 8
forward 3
down 1
down 9
forward 1
down 3
up 9
up 3
forward 8
up 2
down 4
up 5
up 4
down 9
down 5
up 3
forward 2
down 8
forward 8
forward 7
up 4
down 9
down 6
up 1
forward 9
up 8
forward 4
up 3
down 4
up 2
up 7
down 2
forward 3
down 8
down 9
up 7
up 8
forward 3
forward 1
forward 7
forward 5
forward 9
forward 2
up 1
down 1
up 4
forward 1
up 9
forward 7
forward 2
down 6
down 5
forward 9
forward 4
down 6
down 6
up 8
down 3
up 8
down 3
forward 2
down 1
down 1
forward 5
down 1
forward 9
up 8
forward 2
down 5
up 8
up 8
forward 8
forward 8
forward 3
forward 2
forward 8
forward 9
forward 8
forward 6
forward 4
up 7
forward 9
forward 8
up 7
forward 6
forward 9
forward 8
down 7
forward 9
down 4
down 1
up 1
up 9
forward 2
down 6
down 2
down 8
down 6
up 8
forward 7
up 9
forward 5
forward 4
forward 8
up 4
forward 4
up 6
forward 7
forward 1
up 8
down 6
forward 7
forward 3
forward 2
down 4
forward 4
down 7
down 6
down 2
up 3
up 5
down 7
down 9
up 8
down 1
up 1
down 8
up 8
forward 8
down 6
down 1
down 6
forward 3
down 9
down 5
up 3
down 1
down 1
forward 4
down 4
up 3
forward 8
up 4
down 3
down 5
down 3
forward 6
forward 3
down 2
forward 9
forward 3
forward 2
down 2
forward 6
down 1
down 1
forward 5
forward 4
forward 6
down 7
forward 7
forward 3
forward 1
up 3
down 6
forward 1
up 9
forward 9
forward 5
forward 3
forward 3
down 3
up 8
forward 5
up 6
forward 2
down 7
forward 2
forward 8
forward 8
forward 3
up 9
down 5
down 3
forward 7
up 9
forward 4
down 1
down 3
down 5
down 2
forward 9
up 6
down 3
down 7
down 3
up 6
forward 3
down 4
forward 2
down 8
down 2
forward 7
down 2
down 9
forward 1
down 1
down 9
down 6
forward 5
down 1
up 1
forward 5
forward 4
forward 9
down 3
forward 3
forward 5
down 9
forward 9
down 8
down 2
forward 1
up 1
down 5
forward 2
up 9
forward 9
forward 7
forward 9
forward 3
down 7
forward 2
down 4
up 3
down 7
down 6
forward 2
down 2
forward 8
up 9
down 1
forward 7
down 8
forward 3
down 2
down 5
down 5
down 3
forward 1
up 9
up 9
down 8
down 6
up 7
forward 7
down 4
forward 6
down 9
up 5
up 6
forward 4
forward 1
forward 1
down 7
down 8
down 2
down 4
down 3
up 8
down 3
forward 3
forward 8
up 3
down 2
forward 4
down 3
forward 5
up 1
down 9
down 1
down 4
forward 3
forward 6
forward 7
forward 2
forward 9
forward 1
forward 6
forward 7
forward 2
up 1
down 6
down 1
forward 6
down 6
down 5
forward 1
"""
