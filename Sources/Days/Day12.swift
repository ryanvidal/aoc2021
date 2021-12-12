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
    public typealias CalculationInput = [String:Cave]

    public func ParseInput(_ input: String) -> CalculationInput {
        var system = [String:Cave]()
        let inputLines = input.components(separatedBy: "\n")
        for line in inputLines {
            let caveNames = line.components(separatedBy: "-")
            var (cave1, cave2) = (system[caveNames[0]], system[caveNames[1]])

            if cave1 == nil {
                system[caveNames[0]] = Cave(caveNames[0])
                cave1 = system[caveNames[0]]
            }
            if cave2 == nil {
                system[caveNames[1]] = Cave(caveNames[1])
                cave2 = system[caveNames[1]]
            }
            cave1!.addNeighbor(cave2!)
            cave2!.addNeighbor(cave1!)
        }

        return system
    }

    public func PerformPart1Calculation(_ input: CalculationInput) -> Int? {
        return pathsOut(from: input["start"]!, visitedList: []).count
    }

    public func PerformPart2Calculation(_ input: CalculationInput) -> Int? {
        return leasurlyPathsOut(from: input["start"]!, priorVisitations: [:]).count
    }

    private func pathsOut(from cave: Cave, visitedList: Set<Cave>) -> [[Cave]] {
        guard cave.name != "end" else { return [[cave]] }

        var paths = [[Cave]]()
        let visited = visitedList.union([cave])

        for neighbor in cave.neighbors.filter({ $0.isLarge || !visited.contains($0) }) {

            let pathsFromNeighbor = pathsOut(from: neighbor, visitedList: visited)
            for path in pathsFromNeighbor {
                paths.append([cave] + path)
            }
        }

        return paths
    }

    private func leasurlyPathsOut(from cave: Cave, priorVisitations: [Cave:Int]) -> [[Cave]] {
        guard cave.name != "end" else { return [[cave]] }

        var paths = [[Cave]]()
        var visitations = priorVisitations
        visitations[cave] = (visitations[cave] != nil) ? (visitations[cave]! + 1) : 1

        for neighbor in cave.neighbors.filter({ neighbor in
            if neighbor.isLarge || neighbor.name == "end" { return true }
            if neighbor.name == "start" { return false }

            let someCaveVisitedTwice = visitations.contains(where: { $0.key.isSmall && $0.value == 2 })
            return visitations[neighbor] ?? 0 < (someCaveVisitedTwice ? 1 : 2)
        }) {
            let pathsFromNeighbor = leasurlyPathsOut(from: neighbor, priorVisitations: visitations)
            for path in pathsFromNeighbor {
                paths.append([cave] + path)
            }
        }

        return paths
    }
}

public class Cave {
    let name: String
    var neighbors: Set<Cave> = []

    init(_ name: String) { self.name = name }

    func addNeighbor(_ cave: Cave) {
        neighbors.insert(cave)
    }

    var isLarge: Bool {
        return name == name.uppercased()
    }

    var isSmall: Bool {
        return !isLarge
    }
}

extension Cave: Hashable {
    public static func == (lhs: Cave, rhs: Cave) -> Bool {
        return lhs.name == rhs.name
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

fileprivate let testInputString = """
start-A
start-b
A-c
A-b
b-d
A-end
b-end
"""
//
//fileprivate let testInputString = """
//dc-end
//HN-start
//start-kj
//dc-start
//dc-HN
//LN-dc
//HN-end
//kj-sa
//kj-HN
//kj-dc
//"""

//fileprivate let testInputString = """
//fs-end
//he-DX
//fs-he
//start-DX
//pj-DX
//end-zg
//zg-sl
//zg-pj
//pj-he
//RW-he
//fs-DX
//pj-RW
//zg-RW
//start-pj
//he-WI
//zg-he
//pj-fs
//start-RW
//"""

fileprivate let puzzleInputString = """
CI-hb
IK-lr
vr-tf
lr-end
XP-tf
start-vr
lr-io
hb-qi
end-CI
tf-YK
end-YK
XP-lr
XP-vr
lr-EU
tf-CI
EU-vr
start-tf
YK-hb
YK-vr
start-EU
lr-CI
hb-XP
XP-io
tf-EU
"""
