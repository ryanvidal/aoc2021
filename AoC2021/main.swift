//
//  main.swift
//  AoC2021
//
//  Created by Ryan Vidal on 11/26/21.
//

import Foundation

let days: [DailyPuzzle] = [
    DayExample(),
    Day1(),
    Day2(),
]

let whichDay = 1
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
