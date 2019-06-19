//
//  InputDeviceInteractable.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 15/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import Foundation
import SpriteKit

/// Nodes that implement this protocol are able to receive interaction through an input device such
/// as a mouse, keyboard or gamepad. These nodes can also receive focus when displayed in the menu.
protocol InputDeviceInteractable where Self: SKNode {
    func handleInput(action: InputDeviceAction)
}

/// An OptionSet that can contain multiple simultaneous actions. For example when using a gamepad,
// 2 buttons might be pressed at the same time.
public struct InputDeviceAction: OptionSet, CustomStringConvertible {
    public let rawValue: Int16
    
    static let none = InputDeviceAction(rawValue: 0)
    
    static let up = InputDeviceAction(rawValue: 1 << 0)
    static let down = InputDeviceAction(rawValue: 1 << 1)
    static let left = InputDeviceAction(rawValue: 1 << 2)
    static let right = InputDeviceAction(rawValue: 1 << 3)
    static let buttonA = InputDeviceAction(rawValue: 1 << 4)
    static let buttonB = InputDeviceAction(rawValue: 1 << 5)

    static let all: InputDeviceAction = [.up, .down, .left, .right, .buttonA, .buttonB]
    
    public init(rawValue: Int16) {
        self.rawValue = rawValue
    }
    
    public var description: String {
        var input: [String] = []
        
        switch self {
        case _ where contains(.up): input.append("↑")
        case _ where contains(.down): input.append("↓")
        case _ where contains(.left): input.append("←")
        case _ where contains(.right): input.append("→")
        case _ where contains(.buttonA): input.append("◎ A")
        case _ where contains(.buttonB): input.append("◎ B")
        case _ where self == InputDeviceAction.none: input.append("-")
        default: break
        }
        
        return input.joined(separator: ", ")
    }
}
