//
//  Functions.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 17/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import Foundation

func assertRange(_ range: ClosedRange<Int>, minimumDistance: Int) {
    assert((range.upperBound - range.lowerBound) >= minimumDistance, "The range \(range) should have a distance of at least \(minimumDistance)")
}

func assertArray(_ array: [Any], minimumLength: Int) {
    assert(array.count >= minimumLength, "The array \(array) should have a length of at least \(minimumLength)")
}
