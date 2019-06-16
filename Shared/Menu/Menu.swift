//
//  Menu.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 15/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import Foundation

public class Menu {
    let items: [MenuItem]
    let title: String?
    let configuration: MenuBuilder.Configuration
    
    internal init(title: String?, items: [MenuItem], configuration: MenuBuilder.Configuration) {
        self.title = title
        self.items = items
        self.configuration = configuration
    }
}
