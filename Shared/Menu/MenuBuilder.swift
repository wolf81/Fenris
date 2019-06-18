//
//  MenuBuilder.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 15/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import Foundation

/// Conform to the MenuBuilder protocol to create custom menus or use the provided SimpleMenuBuilder
/// or LabeledMenuBuilder instead.
public protocol MenuBuilder {
    func build() -> Menu
}

/// The simple menu builder can be used to create a 1-column menu, usable for example as a main
/// menu in a game
public class SimpleMenuBuilder: MenuBuilder {
    private var listItems: [[MenuItem]] = []

    public init() {}
    
    public func withRow(item: MenuItem) -> Self {
        self.listItems.append([item])
        return self
    }
    
    public func withEmptyRow() -> Self {
        self.listItems.append([FixedSpaceItem()])
        return self
    }
    
    public func build() -> Menu {
        return Menu(headerItems: [], listItems: self.listItems, footerItems: [])
    }
}

/// The labeled menu builder can be used to create a 2-column menu, appropriate for screens like
/// settings.
public class LabeledMenuBuilder: MenuBuilder {
    private var headerItems: [MenuItem] = []
    private var footerItems: [MenuItem] = []
    private var listItems: [[MenuItem]] = []
    
    public init() {}
    
    public func withHeader(title: String) -> Self {
        self.headerItems = [LabelItem(title: title)]
        return self
    }
        
    public func withRow(title: String, item: MenuItem) -> Self {
        self.listItems.append([LabelItem(title: title), item])
        return self
    }
    
    public func withEmptyRow() -> Self {
        self.listItems.append([FixedSpaceItem(), FixedSpaceItem()])
        return self
    }
    
    public func withFooter(items: [MenuFooterContainable]) -> Self {
        self.footerItems = items
        return self
    }
    
    public func build() -> Menu {
        return Menu(headerItems: self.headerItems, listItems: self.listItems, footerItems: self.footerItems)
    }
}
