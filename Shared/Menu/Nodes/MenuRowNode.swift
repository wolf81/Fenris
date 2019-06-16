//
//  MenuRowNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 15/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

class MenuRowNode: SKShapeNode {
    private(set) var itemNodes: [MenuItemNode] = []
    
    init(size: CGSize, items: [MenuItem], font: Font) {
        super.init()
        
        self.path = CGPath(rect: CGRect(origin: .zero, size: size), transform: nil)
        self.lineWidth = 0
        
        for (idx, item) in items.enumerated() {
            let nodeSize = CGSize(width: size.width / CGFloat(items.count), height: size.height)
            let node = item.getNode(size: nodeSize, font: font)
            addChild(node)
            node.position = CGPoint(x: CGFloat(idx) * nodeSize.width, y: 0)
            self.itemNodes.append(node)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }    
}
