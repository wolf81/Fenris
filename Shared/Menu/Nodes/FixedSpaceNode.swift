//
//  FixedSpaceNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 15/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

class FixedSpaceNode: SKShapeNode, MenuItemNode {
    let item: MenuItem
    
    init(size: CGSize, item: FixedSpaceItem) {
        self.item = item
        
        super.init()
        
        self.path = CGPath(rect: .init(origin: .zero, size: size), transform: nil)
        self.lineWidth = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
