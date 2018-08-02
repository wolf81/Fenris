//
//  LabelNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 02/08/2018.
//  Copyright © 2018 Wolftrail. All rights reserved.
//

import SpriteKit

class LabelNode: SKShapeNode, MenuNode {
    var titleLabelMaxX: CGFloat 
    
    var titleLabel: SKLabelNode

    required init(option: Label) {
        self.titleLabel = SKLabelNode(text: option.title)
        self.titleLabel.horizontalAlignmentMode = .left
        self.titleLabel.verticalAlignmentMode = .center

        let titleLabelFrame = self.titleLabel.calculateAccumulatedFrame()
        self.titleLabelMaxX = titleLabelFrame.maxX
        
        super.init()

        self.path = CGPath(rect: titleLabelFrame, transform: nil)

        self.titleLabel.position = CGPoint(x: 0, y: 0)

        addChild(self.titleLabel)

        self.strokeColor = SKColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func calculateAccumulatedFrame() -> CGRect {
        return self.titleLabel.calculateAccumulatedFrame()
    }
}
