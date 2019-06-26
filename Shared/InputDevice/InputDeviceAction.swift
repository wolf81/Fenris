//
//  InputDeviceAction.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 25/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import Foundation
import CoreGraphics

public struct Point {
    public let x: UInt16
    public let y: UInt16
    
    public init(x: UInt16, y: UInt16) {
        self.x = x
        self.y = y
    }        
        
    var cgPoint: CGPoint {
        return CGPoint(x: Int(self.x), y: Int(self.y))
    }
}

public struct InputDeviceAction: OptionSet {
    public let rawValue: UInt64
    
    public init(rawValue: UInt64) {
        self.rawValue = rawValue
    }
    
    static let none = InputDeviceAction(rawValue: 0)
    
    static let left = InputDeviceAction(rawValue: 1 << 0)
    static let right = InputDeviceAction(rawValue: 1 << 1)
    static let up = InputDeviceAction(rawValue: 1 << 2)
    static let down = InputDeviceAction(rawValue: 1 << 3)
    static let action1 = InputDeviceAction(rawValue: 1 << 4)
    static let action2 = InputDeviceAction(rawValue: 1 << 5)

    static let pause = InputDeviceAction(rawValue: 1 << 6)
    
    // 16 bytes for xCoord, 16 for yCoord - should be large enough for many screens for years to come
    static let pointUp = InputDeviceAction(rawValue: 1 << 30)
    static let pointMove = InputDeviceAction(rawValue: 1 << 31) 
    static let xCoord = InputDeviceAction(rawValue: (1 << 64) - (1 << 32))
    static let yCoord = InputDeviceAction(rawValue: (1 << 64) - (1 << 16))
    
    // probably need at least pointer move and pointer up flags
    
    public func getPointUp() -> Point? {
        // if pointer flag was not set, assume no point stored.
        guard self.contains(.pointUp) else { return nil }
        
        let x = UInt16(self.rawValue >> 32 & 65535)
        let y = UInt16(self.rawValue >> 48 & 65535)
        return Point(x: x, y: y)
    }
    
    public func getPointMove() -> Point? {
        // if pointer flag was not set, assume no point stored.
        guard self.contains(.pointMove) else { return nil }
        
        let x = UInt16(self.rawValue >> 32 & 65535)
        let y = UInt16(self.rawValue >> 48 & 65535)
        return Point(x: x, y: y)
    }
    
    public mutating func setPointMove(_ point: Point) {
        var value = self.rawValue
        
        // set pointer move flag to true, indicating we have a point stored
        value |= InputDeviceAction.pointMove.rawValue
        
        // clear old x and y values
        value = value & 0b0000_0000_0000_0000_0000_0000_0000_0000_1111_1111_1111_1111_1111_1111_1111_1111
        
        // set new x & y values
        value |= UInt64(point.x) << 32
        value |= UInt64(point.y) << (32 + 16)
        
        self = InputDeviceAction(rawValue: value)
    }
    
    public mutating func setPointUp(_ point: Point) {
        var value = self.rawValue
        
        // set pointer up flag to true, indicating we have a point stored
        value |= InputDeviceAction.pointUp.rawValue
        
        // clear old x and y values
        value = value & 0b0000_0000_0000_0000_0000_0000_0000_0000_1111_1111_1111_1111_1111_1111_1111_1111
        
        // set new x & y values
        value |= UInt64(point.x) << 32
        value |= UInt64(point.y) << (32 + 16)
        
        self = InputDeviceAction(rawValue: value)
    }
    
    public mutating func removePointUp() {
        var value = self.rawValue
        
        // clear pointer flag, indicating no point stored
        value &= ~(InputDeviceAction.pointUp.rawValue)
        
        // clear old x and y values
        value = value & 0b0000_0000_0000_0000_0000_0000_0000_0000_1111_1111_1111_1111_1111_1111_1111_1111

        self = InputDeviceAction(rawValue: value)
    }
    
    public mutating func removePointMove() {
        var value = self.rawValue
        
        // clear pointer flag, indicating no point stored
        value &= ~(InputDeviceAction.pointMove.rawValue)
        
        // clear old x and y values
        value = value & 0b0000_0000_0000_0000_0000_0000_0000_0000_1111_1111_1111_1111_1111_1111_1111_1111
        
        self = InputDeviceAction(rawValue: value)
    }
}
