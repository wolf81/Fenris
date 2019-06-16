//
//  Menu.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 15/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import Foundation

/// A Menu to display in a scene. Please note: the menu cannot be instantiated directly, instead
/// make use of the MenuBuilder to create in instance.
public class Menu {
    let items: [MenuItem]
    let title: String?
    let configuration: MenuBuilder.Configuration
    let footerItems: [MenuFooterContainable]
    
    internal init(title: String?, items: [MenuItem], footerItems: [MenuFooterContainable], configuration: MenuBuilder.Configuration) {
        self.title = title
        self.items = items
        self.footerItems = footerItems
        self.configuration = configuration
    }
}
