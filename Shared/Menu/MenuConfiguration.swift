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
    var footerMinimumHorizontalSpacing: CGFloat { get }
}

public extension MenuConfiguration {
    var menuWidth: CGFloat { 400 }
    
    var rowHeight: CGFloat { 40 }

    var titleFont: Font { Font(name: "Helvetica", size: 20)! }

    var labelFont: Font { Font(name: "Helvetica", size: 16)! }
    
    var footerMinimumHorizontalSpacing: CGFloat { 5 }

    var focusRectColor: SKColor { SKColor.yellow }
}
