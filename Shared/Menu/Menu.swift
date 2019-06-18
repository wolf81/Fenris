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
public struct Menu {
    let headerItems: [MenuItem]
    let footerItems: [MenuItem]
    let listItems: [[MenuItem]]

    init(headerItems: [MenuItem], listItems: [[MenuItem]], footerItems: [MenuItem]) {
        self.headerItems = headerItems
        self.listItems = listItems
        self.footerItems = footerItems        
    }
}
