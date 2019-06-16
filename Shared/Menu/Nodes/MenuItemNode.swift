//
//  MenuItemNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 15/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

public protocol MenuItemNode where Self: SKNode {
    var item: MenuItem { get }
}
