//
//  LabelNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 14/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

class LabelNode: SKShapeNode {    
    init(size: CGSize, font: Font, text: String) {
        super.init()
        
        self.strokeColor = .clear
        self.lineWidth = 0
        
        let label = SKLabelNode(text: text)
        label.font = font
        addChild(label)
        
        label.position = CGPoint(x: size.width / 2, y: (size.height - font.capHeight) / 2)
        
        self.path = CGPath(rect: .init(origin: .zero, size: size), transform: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
