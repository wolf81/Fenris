//
//  ScrollbarNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 14/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import SpriteKit

class ScrollbarNode : SKSpriteNode {
    let upButton: ButtonNode
    let downButton: ButtonNode

    public override init(texture: SKTexture?, color: NSColor, size: CGSize) {
        let buttonSize = CGSize(width: 32, height: 32)

        self.upButton = ButtonNode(title: "▲", size: buttonSize)
        self.downButton = ButtonNode(title: "▼", size: buttonSize)
        
        super.init(texture: texture, color: color, size: size)
                
        self.upButton.position = CGPoint(x: buttonSize.width / 2, y: size.height - buttonSize.height / 2)
        self.addChild(self.upButton)
        
        self.downButton.position = CGPoint(x: buttonSize.width / 2, y: buttonSize.height / 2)
        self.addChild(self.downButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
