//
//  Menu.Configuration.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 15/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit
import CoreGraphics

/// A menu configuration contains verious properties used for display of the menu.
public protocol MenuConfiguration {
    var menuWidth: CGFloat { get }
    var rowHeight: CGFloat { get }
    var titleFont: Font { get }
    var labelFont: Font { get }
    var focusRectColor: SKColor { get }
}

public extension MenuConfiguration {
    var focusRectColor: SKColor { return SKColor.yellow }
}
