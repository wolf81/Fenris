//
//  CGPointExtensions.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 26/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import CoreGraphics

extension CGPoint {
    var point: Point {
        let validRange = 0 ..< Int(UInt16.max)
        let x = constrain(value: Int(self.x), to: validRange)
        let y = constrain(value: Int(self.y), to: validRange)
        return Point(x: UInt16(x), y: UInt16(y))
    }
}
