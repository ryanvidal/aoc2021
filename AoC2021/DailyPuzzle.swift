//
//  DailyPuzzle.swift
//  AoC2021
//
//  Created by Ryan Vidal on 11/26/21.
//

import Foundation

public protocol DailyPuzzle {
    func SolvePart1Test() -> String
    func SolvePart2Test() -> String
    func SolvePart1() -> String
    func SolvePart2() -> String
}
