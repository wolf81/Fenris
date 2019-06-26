//
//  Functions.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 21/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

internal func initializeInputDeviceManagerIfNeeded(scene: (SKScene & InputDeviceInteractable)) {
//    if (try? ServiceLocator.shared.get(service: InputDeviceManager.self)) == nil {
//        try? ServiceLocator.shared.add(service: InputDeviceManager())
//    }
//    
//    let manager = try! ServiceLocator.shared.get(service: InputDeviceManager.self)
//    manager.interactableScene = scene
}

internal func constrain(value: IntegerLiteralType, to range: Range<IntegerLiteralType>) -> IntegerLiteralType {
    var value = value
    switch value {
    case _ where range.count == 0:
        value = IntegerLiteralType.min
    case _ where value < range.lowerBound:
        value = range.lowerBound
    case _ where value >= range.upperBound:
        value = (range.upperBound - 1)
    default:
        break
    }
    return value
}
