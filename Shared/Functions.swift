//
//  Functions.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 21/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

internal func initializeInputDeviceManagerIfNeeded(scene: (SKScene & InputDeviceInteractable), onInputDeviceChanged: ((InputDeviceScheme) -> Void)?) {
    if (try? ServiceLocator.shared.get(service: InputDeviceManager.self)) == nil {
        try? ServiceLocator.shared.add(service: InputDeviceManager())
    }
    
    let manager = try! ServiceLocator.shared.get(service: InputDeviceManager.self)
    manager.interactableScene = scene
    manager.onSchemeChange = onInputDeviceChanged
}
