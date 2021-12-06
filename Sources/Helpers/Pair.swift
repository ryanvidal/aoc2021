//
//  Pair.swift
//  AoC2021
//
//  Created by Ryan Vidal on 12/6/21.
//

import Foundation

public struct Pair: Hashable {
    let val: (Int, Int)

    init(_ x: Int, _ y: Int) {
        val = (x, y)
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(val.0)
        hasher.combine(val.1)
    }

    static public func ==(left: Pair, right: Pair) -> Bool {
        return left.val == right.val
    }
}
