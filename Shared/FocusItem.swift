//
//  FocusItem.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 16/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import Foundation
import SpriteKit

/// A focus item is an item that can receive focus in the UI, in the menu this is indicated by
/// showing a box around the focused control. Only 1 node can receive focus at any time.
struct FocusItem {
    
    /// The frame to use for display of the focus box.
    let frame: CGRect
    
    /// A node that can receive interaction through an input device.
    let interactableNode: SKNode & InputDeviceInteractable
}
