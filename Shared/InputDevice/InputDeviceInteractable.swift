//
//  InputDeviceInteractable.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 15/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import Foundation
import SpriteKit

public protocol MouseDeviceInteractable where Self: SKNode {
    func handleMouseUp(location: CGPoint)
    func handleMouseMoved(location: CGPoint)
}

public protocol KeyboardDeviceInteractable where Self: SKNode {
    func handleKeyUp(action: KeyboardAction)
}

public protocol GameControllerDeviceInteractable where Self: SKNode {
    func handleInput(action: GameControllerAction)
}

public protocol TouchDeviceInteractable where Self: SKNode {
    
}

public typealias InputDeviceInteractable = (
    TouchDeviceInteractable &
    MouseDeviceInteractable &
    KeyboardDeviceInteractable &
    GameControllerDeviceInteractable
)

public struct KeyboardAction: OptionSet {
    public let rawValue: Int16
    
    static let none = KeyboardAction(rawValue: 0)

    static let up = KeyboardAction(rawValue: 1 << 0)
    static let down = KeyboardAction(rawValue: 1 << 1)
    static let left = KeyboardAction(rawValue: 1 << 2)
    static let right = KeyboardAction(rawValue: 1 << 3)
    static let action1 = KeyboardAction(rawValue: 1 << 4)
    static let action2 = KeyboardAction(rawValue: 1 << 5)
    
    static let all: KeyboardAction = [.up, .down, .left, .right, .action1, .action2]
    
    public init(rawValue: Int16) {
        self.rawValue = rawValue
    }
}

/// An OptionSet that can contain multiple simultaneous actions. For example when using a gamepad,
// 2 buttons might be pressed at the same time.
public struct GameControllerAction: OptionSet, CustomStringConvertible {
    public let rawValue: Int16
    
    static let none = GameControllerAction(rawValue: 0)
    
    static let up = GameControllerAction(rawValue: 1 << 0)
    static let down = GameControllerAction(rawValue: 1 << 1)
    static let left = GameControllerAction(rawValue: 1 << 2)
    static let right = GameControllerAction(rawValue: 1 << 3)
    static let buttonA = GameControllerAction(rawValue: 1 << 4)
    static let buttonB = GameControllerAction(rawValue: 1 << 5)

    static let all: GameControllerAction = [.up, .down, .left, .right, .buttonA, .buttonB]
    
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
        case _ where self == GameControllerAction.none: input.append("-")
        default: break
        }
        
        return input.joined(separator: ", ")
    }
}

