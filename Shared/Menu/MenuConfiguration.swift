//
//  MenuConfiguration.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 13/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import Foundation

public struct MenuConfiguration {
    public let menuWidth: CGFloat
    public let itemHeight: CGFloat
    public let font: Font
    
    public init(menuWidth: CGFloat, itemHeight: CGFloat, font: Font) {
        self.menuWidth = menuWidth
        self.itemHeight = itemHeight
        self.font = font
    }
}
