//
//  Menu.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 15/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import Foundation
import CoreFoundation

public class Menu {
    let items: [Item]
    let title: String
    let configuration: Configuration
    
    public init(title: String, items: [Item], configuration: Configuration) {
        self.title = title
        self.items = items
        self.configuration = configuration
    }
}

extension Menu {
    public struct Configuration {
        let menuWidth: CGFloat
        let rowHeight: CGFloat
        let titleFont: Font
        let labelFont: Font
        
        public init(menuWidth: CGFloat, rowHeight: CGFloat, titleFont: Font, labelFont: Font) {
            self.menuWidth = menuWidth
            self.rowHeight = rowHeight
            self.titleFont = titleFont
            self.labelFont = labelFont
        }
    }
}

