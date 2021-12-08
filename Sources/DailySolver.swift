//
//  DailySolver.swift
//  AoC2021
//
//  Created by Ryan Vidal on 12/1/21.
//

import Foundation

public protocol DailySolver {
    associatedtype CalculationInput
    func ParseInput(_ input: String) -> CalculationInput
    func PerformPart1Calculation(_ input: CalculationInput) -> Int?
    func PerformPart2Calculation(_ input: CalculationInput) -> Int?
}
