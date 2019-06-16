//
//  MenuBuilder.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 15/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import Foundation

/// The MenuBuilder can be used to generate a menu.
public class MenuBuilder {
    private let configuration: Configuration
    private var items: [MenuItem] = []
    private var footerItems: [MenuFooterContainable] = []
    private var title: String?
    
    public init(configuration: Configuration) {
        self.configuration = configuration
    }
    
    public func withHeader(title: String) -> Self {
        self.title = title
        return self
    }
        
    public func withRow(title: String, item: MenuItem) -> Self {
        self.items.append(contentsOf: [LabelItem(title: title), item])
        return self
    }
    
    public func withEmptyRow() -> Self {
        self.items.append(contentsOf: [FixedSpaceItem(), FixedSpaceItem()])
        return self
    }
    
    public func withFooter(items: [MenuFooterContainable]) -> Self {
        self.footerItems = items
        return self
    }
    
    public func build() -> Menu {
        return Menu(title: self.title, items: self.items, footerItems: self.footerItems, configuration: self.configuration)
    }
}
