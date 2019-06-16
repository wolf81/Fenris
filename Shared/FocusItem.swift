//
//  FocusItem.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 16/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import Foundation
import SpriteKit

struct FocusItem {
    let frame: CGRect
    let interactableNode: SKNode & InputDeviceInteractable
}
