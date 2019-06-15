//
//  Menu.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 15/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import Foundation
import CoreFoundation

extension MenuBuilder {
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
}
