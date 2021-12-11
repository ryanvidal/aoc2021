//
//  Day11.swift
//  AoC2021
//
//  Created by Ryan Vidal on 12/11/21.
//

import Algorithms
import Foundation

public let day11 = DailyPuzzleBase(solver: Day11Solver(),
                                       testInput: testInputString,
                                       puzzleInput: puzzleInputString)

public class Day11Solver: DailySolver {
    public typealias CalculationInput = [Octopus]

    public func ParseInput(_ input: String) -> CalculationInput {
        let inputLines = input.components(separatedBy: "\n")
        var octopuses = [Pair:Octopus]()
        for (y, line) in inputLines.enumerated() {
            for (x, c) in line.enumerated() {
                octopuses[Pair(x,y)] = Octopus(c.wholeNumberValue!)
            }
        }
        for octopus in octopuses {
            let (x,y) = (octopus.key.x, octopus.key.y)
            for location in product(x-1...x+1, y-1...y+1).map({ Pair($0.0, $0.1) }) {
                octopus.value.addNeighbor(neighbor: octopuses[location])
            }
        }
        return octopuses.map { $0.value }
    }

    public func PerformPart1Calculation(_ input: CalculationInput) -> Int? {
        var flashCount = 0
        for _ in 1...100 {
            flashCount += performStep(octopuses: input)
        }

        return flashCount
    }

    public func PerformPart2Calculation(_ input: CalculationInput) -> Int? {
        var step = 1
        while performStep(octopuses: input) != 100 {
            step += 1
        }

        return step
    }

    private func performStep(octopuses: [Octopus]) -> Int {
        for octopus in octopuses {
            octopus.charge()
        }
        for octopus in octopuses {
            octopus.flashIfReady()
        }
        return octopuses.reduce(0) { $0 + ($1.hasFlashed() ? 1 : 0) }
    }
}

public class Octopus {
    var energy: Int
    var neighbors: [Octopus] = []
    var isFlashing: Bool = false

    init(_ energy: Int) {
        self.energy = energy
    }

    func addNeighbor(neighbor: Octopus?) {
        guard let neighbor = neighbor else { return }
        neighbors.append(neighbor)
    }

    func charge() {
        energy += 1
    }

    func flashIfReady() {
        guard !isFlashing else { return }
        if energy > 9 {
            isFlashing = true
            for neighbor in neighbors {
                neighbor.charge()
            }
            for neighbor in neighbors {
                neighbor.flashIfReady()
            }
        }
    }

    func hasFlashed() -> Bool {
        if isFlashing {
            isFlashing = false
            energy = 0
            return true
        }

        return false
    }
}

fileprivate let testInputString = """
5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526
"""

fileprivate let puzzleInputString = """
2524255331
1135625881
2838353863
1662312365
6847835825
2185684367
6874212831
5387247811
2255482875
8528557131
"""
