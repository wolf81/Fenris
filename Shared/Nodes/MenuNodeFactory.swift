//
//  MenuNodeFactory.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 02/08/2018.
//  Copyright © 2018 Wolftrail. All rights reserved.
//

import SpriteKit

class MenuNodeFactory {
    static func menuNodeFor(option: MenuOption) -> (SKShapeNode)? {
        switch option {
        case let label as Label:
            return LabelNode(option: label)
        case let toggle as Toggle:
            return ToggleNode(option: toggle)
        case let numberPicker as NumberPicker:
            return NumberPickerNode(option: numberPicker)
        default:
            return nil
        }
    }
}
