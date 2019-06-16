//
//  Menu.Configuration.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 15/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import Foundation

extension MenuBuilder {
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
