//
//  DefaultMenuConfiguration.swift
//  Demo macOS
//
//  Created by Wolfgang Schreurs on 19/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import Fenris
import SpriteKit

class DefaultMenuConfiguration: MenuConfiguration {
    var titleFont: Font { Font(name: "Papyrus", size: 22)! }
    
    var labelFont: Font { Font(name: "Papyrus", size: 18)! }
    
    var menuWidth: CGFloat { 460 }
    
    var rowHeight: CGFloat { 40 }
    
    var focusRectColor: SKColor { SKColor.yellow }
    
    private init() {}
    
    public static let shared = DefaultMenuConfiguration()
}
