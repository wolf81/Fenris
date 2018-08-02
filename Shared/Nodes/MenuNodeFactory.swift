//
//  MenuNodeFactory.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 02/08/2018.
//  Copyright © 2018 Wolftrail. All rights reserved.
//

import SpriteKit

class MenuNodeFactory {
    static func menuNodeFor(option: MenuOption) -> (SKShapeNode & MenuNode)? {
        switch option {
        case let label as Label:
            return LabelNode(title: label.title)
        case let toggle as Toggle:
            return ToggleNode(title: toggle.title, checked: toggle.checked)
        case let numberPicker as NumberPicker:
            return NumberPickerNode(title: numberPicker.title,
                                    range: numberPicker.range,
                                    value: numberPicker.value)
        default:
            return nil
        }
    }
}
