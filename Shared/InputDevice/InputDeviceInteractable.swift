//
//  InputDeviceInteractable.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 15/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import Foundation
import SpriteKit

public protocol InputDeviceInteractable where Self: SKNode {
    func handlePress(_ action: InputDeviceAction)
    func handleRelease(_ action: InputDeviceAction)
}
