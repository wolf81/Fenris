//
//  MenuNodeFactory.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 02/08/2018.
//  Copyright © 2018 Wolftrail. All rights reserved.
//

import SpriteKit

enum MenuNodeFactoryError: LocalizedError {
    case unknownNodeTypeForOption(MenuOption)
    
    var errorDescription: String? {
        switch self {
        case .unknownNodeTypeForOption(let option):
            return "\(type(of: MenuNodeFactory.self)) can't create nodes for option \(option)"
        }
    }
}

class MenuNodeFactory {
    static func menuNodeFor(option: MenuOption, nodeHeight: CGFloat) throws -> SKShapeNode {
        switch option {
        case let toggle as Toggle:
            return try ToggleNode(option: toggle)
        case let chooser as Chooser:
            return try ChooserNode(option: chooser)
        case let button as Button:
            return try ButtonNode(option: button)
        default:
            throw MenuNodeFactoryError.unknownNodeTypeForOption(option)
        }
    }
}
