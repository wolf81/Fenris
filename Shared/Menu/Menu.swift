//
//  Menu.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 15/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import Foundation
import CoreFoundation

public class MenuBuilder {
    private let configuration: Menu.Configuration
    private var items: [Item] = []
    private var title: String?
    
    public init(configuration: Menu.Configuration) {
        self.configuration = configuration
    }
    
    public func withHeader(title: String) -> MenuBuilder {
        self.title = title
        return self
    }
    
    public func withRow(title: String, item: Item) -> MenuBuilder {
        self.items.append(contentsOf: [LabelItem(title: title), item])
        return self
    }
    
    public func withEmptyRow() -> MenuBuilder {
        self.items.append(contentsOf: [FixedSpaceItem(), FixedSpaceItem()])
        return self
    }
    
    public func build() -> Menu {
        return Menu(title: self.title ?? "", items: self.items, configuration: self.configuration)
    }
}

public class Menu {
    let items: [Item]
    let title: String
    let configuration: Configuration
    
    internal init(title: String, items: [Item], configuration: Configuration) {
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

