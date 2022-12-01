//
//  Day14.swift
//  AoC2021
//
//  Created by Ryan Vidal on 12/14/21.
//

import Algorithms
import Foundation

public let day14 = DailyPuzzleBase(solver: Day14Solver(),
                                       testInput: testInputString,
                                       puzzleInput: puzzleInputString)

public class Day14Solver: DailySolver {
    public typealias CalculationInput = Day14State

    public func ParseInput(_ input: String) -> CalculationInput {
        return Day14State(input)
    }

    public func PerformPart1Calculation(_ input: CalculationInput) -> Int? {
        var newPolymer = input

        for _ in 1...10 {
//            newPolymer.makeNaiveInsertions()
            newPolymer.makeInsertions()
        }

//        return newPolymer.elementCountDifferenceFromPolymer
        return newPolymer.elementCountDifference
    }

    public func PerformPart2Calculation(_ input: CalculationInput) -> Int? {
        var newPolymer = input

        for _ in 1...40 {
            newPolymer.makeInsertions()
        }

        return newPolymer.elementCountDifference
    }
}

//public struct Day14State {
//    var polymer: String
//    let rules: [String:String]
//
//    init(_ input: String) {
//        var _rules = [String:String]()
//
//        let components = input.components(separatedBy: "\n").split(separator: "")
//        self.polymer = components[0][0]
//        for rule in components[1] {
//            let ruleComponents = rule.components(separatedBy: " -> ")
//            _rules[ruleComponents[0]] = ruleComponents[1]
//        }
//        self.rules = _rules
//    }
//
//    mutating func makeInsertions() {
//        var newPolymer = ""
//        for pair in polymer.windows(ofCount: 2) {
//            newPolymer.append(pair.first!)
//            if let c = rules[String(pair)] {
//                newPolymer += c
//            }
//        }
//        newPolymer.append(polymer.last!)
//        polymer = newPolymer
//    }
//
//    var elementCountDifference: Int {
//        return polymer.uniqued()
//            .map{ element in polymer.count { $0 == element } }
//    }
//}

public struct Day14State {
    var polymer: String
    let originalPolymer: String
    var pairCounts: [String: Int]
    let rules: [String: String]
    var elementTally: [String.Element: Int]

    init(_ input: String) {
        var _rules = [String:String]()
        pairCounts = [:]

        let components = input.components(separatedBy: "\n").split(separator: "")
        originalPolymer = components[0][0]
        polymer = originalPolymer
        for pair in originalPolymer.windows(ofCount: 2) {
            pairCounts[String(pair)] = 1
        }
        for rule in components[1] {
            let ruleComponents = rule.components(separatedBy: " -> ")
            _rules[ruleComponents[0]] = ruleComponents[1]
        }
        rules = _rules
        elementTally = [:]
        polymer.uniqued().forEach {e in elementTally[e] = polymer.count { $0 == e } }
    }

    mutating func makeInsertions() {
        var pairChanges = [String: Int]()

        for p in pairCounts {
            if let c = rules[p.key] {
                elementTally[c.first!, default: 0] += 1
                let newPair1 = String(p.key.first!) + c
                let newPair2 = c + String(p.key.last!)
                pairChanges[p.key, default: 0] -= p.value
                pairChanges[newPair1, default: 0] += p.value
                pairChanges[newPair2, default: 0] += p.value
            }
        }

        for change in pairChanges {
            pairCounts[change.key, default: 0] += change.value
        }
    }

    mutating func makeNaiveInsertions() {
        var newPolymer = ""
        for pair in polymer.windows(ofCount: 2) {
            newPolymer.append(pair.first!)
            if let c = rules[String(pair)] {
                newPolymer += c
            }
        }
        newPolymer.append(polymer.last!)
//        print("\(polymer) -> \(newPolymer)")
        polymer = newPolymer
    }

    var elementCountDifferenceFromPolymer: Int {
        print("Final element counts:")
        polymer.uniqued().forEach { element in print("\(element): \(polymer.count { $0 == element })") }
        let counts = polymer.uniqued()
            .map{ element in polymer.count { $0 == element } }
            .sorted()
        print("--")
        return counts.last! - counts.first!
    }

    var elementCountDifference: Int {
        print("Final element counts:")
//        var elementCounts = [String.Element: Int]()
//        for pairCount in pairCounts {
//            elementCounts[pairCount.key.first!, default: 0] += pairCount.value
//        }
//        elementCounts[originalPolymer.last!, default: 0] += 1
//        elementCounts.forEach { element in print("\(element.key): \(element.value)")}
//        let counts = elementCounts.values.sorted()
        elementTally.forEach { element in print("\(element.key): \(element.value)")}
        let counts = elementTally.map { $0.value }.sorted()
        print("--")
        return counts.last! - counts.first!
    }
}

fileprivate let testInputString = """
NNCB

CH -> B
HH -> N
CB -> H
NH -> C
HB -> C
HC -> B
HN -> C
NN -> C
BH -> H
NC -> B
NB -> B
BN -> B
BB -> N
BC -> B
CC -> N
CN -> C
"""

fileprivate let puzzleInputString = """
CHBBKPHCPHPOKNSNCOVB

SP -> K
BB -> H
BH -> S
BS -> H
PN -> P
OB -> S
ON -> C
HK -> K
BN -> V
OH -> F
OF -> C
SN -> N
PF -> H
CF -> F
HN -> S
SK -> F
SS -> C
HH -> C
SO -> B
FS -> P
CB -> V
NK -> F
KK -> P
VN -> H
KF -> K
PS -> B
HP -> B
NP -> P
OO -> B
FB -> V
PO -> B
CN -> O
HC -> B
NN -> V
FV -> F
BK -> K
VC -> K
KV -> V
VF -> V
FO -> O
FK -> B
HS -> C
OV -> F
PK -> F
VV -> S
NH -> K
SH -> H
VB -> H
NF -> P
OK -> B
FH -> F
CO -> V
BC -> K
PP -> S
OP -> V
VO -> C
NC -> F
PB -> F
KO -> O
BF -> C
VS -> K
KN -> P
BP -> F
KS -> V
SB -> H
CH -> N
HF -> O
CV -> P
NB -> V
FF -> H
OS -> S
CS -> S
KC -> F
NS -> N
NV -> O
SV -> V
BO -> V
BV -> V
CC -> F
CK -> H
KP -> C
KH -> H
KB -> F
PH -> P
VP -> P
OC -> F
FP -> N
HV -> P
HB -> H
PC -> N
VK -> H
HO -> V
CP -> F
SF -> N
FC -> P
NO -> K
VH -> S
FN -> F
PV -> O
SC -> N
"""
