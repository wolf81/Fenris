//
//  MenuNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 15/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

protocol MenuItemNode where Self: SKShapeNode {
    var item: Item { get }
}
