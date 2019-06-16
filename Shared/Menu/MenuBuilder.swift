//
//  MenuBuilder.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 15/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import Foundation

public class MenuBuilder {
    private let configuration: Configuration
    private var items: [MenuItem] = []
    private var title: String?
    
    public init(configuration: Configuration) {
        self.configuration = configuration
    }
    
    public func withHeader(title: String) -> Self {
        self.title = title
        return self
    }
    
    // TODO: Add footer
    // The footer should probably only allow fixed space and buttons or maybe only buttons
    
    public func withRow(title: String, item: MenuItem) -> Self {
        self.items.append(contentsOf: [LabelItem(title: title), item])
        return self
    }
    
    public func withEmptyRow() -> Self {
        self.items.append(contentsOf: [FixedSpaceItem(), FixedSpaceItem()])
        return self
    }
    
    public func build() -> Menu {
        return Menu(title: self.title, items: self.items, configuration: self.configuration)
    }
}
