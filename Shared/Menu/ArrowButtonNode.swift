//
//  ArrowButtonNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 13/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

class ArrowButtonNode: SKShapeNode {
    init(size: CGSize, direction: ArrowNode.Direction) {
        super.init()
        
        self.path = CGPath(rect: CGRect(origin: .zero, size: size), transform: nil)
        
        self.lineWidth = 0
        self.strokeColor = .clear
        self.fillColor = SKColor.yellow.withAlphaComponent(0.2)
        
        let arrowSize = CGSize(width: size.width / 2, height: size.height / 2)
        
        let arrowNode = ArrowNode(size: arrowSize, direction: direction)
        arrowNode.zPosition = 100
        addChild(arrowNode)
        
        arrowNode.position = CGPoint(x: (size.width - arrowSize.width) / 2, y: (size.height - arrowSize.height) / 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
