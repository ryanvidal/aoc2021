//
//  main.swift
//  AoC2021
//
//  Created by Ryan Vidal on 11/26/21.
//

import Foundation

let days: [DailyPuzzle] = [
    dayExample,
    day1,
    day2,
    day3,
    day4,
    day5,
    day6,
    day7,
    day8,
    day9,
    day10,
    day11,
    day12,
    day13,
    day14,
    day15,
    day16,
    day17,
    day18,
    day19,
    day20,
    day21,
    day22,
    day23,
    day24,
    day25,
]

let whichDay = 12
let dayToRun = days[whichDay]

let part1TestAnswer = dayToRun.SolvePart1Test()
let part1Answer = dayToRun.SolvePart1()
let part2TestAnswer = dayToRun.SolvePart2Test()
let part2Answer = dayToRun.SolvePart2()

let results = """
Results of Day \(whichDay):
------------------

Part 1
---
Test Answer: \(part1TestAnswer)
Final Answer: \(part1Answer)

---
Part 2
---
Test Answer: \(part2TestAnswer)
Final Answer: \(part2Answer)



"""

print(results)
