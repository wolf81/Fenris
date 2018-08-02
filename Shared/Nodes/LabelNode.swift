//
//  LabelNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 02/08/2018.
//  Copyright © 2018 Wolftrail. All rights reserved.
//

import SpriteKit

class LabelNode: SKShapeNode {
    var titleLabel: SKLabelNode
    
    init(title: String) {
        self.titleLabel = SKLabelNode(text: title)
        self.titleLabel.horizontalAlignmentMode = .left
        self.titleLabel.verticalAlignmentMode = .center
        
        let titleLabelFrame = self.titleLabel.calculateAccumulatedFrame()
        
        super.init()
        
        self.path = CGPath(rect: titleLabelFrame, transform: nil)
        
        self.titleLabel.position = CGPoint(x: 0, y: 0)
        
        addChild(titleLabel)
        
        self.strokeColor = SKColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func calculateAccumulatedFrame() -> CGRect {
        return self.titleLabel.calculateAccumulatedFrame()
    }
}

extension LabelNode: TitleAlignableNode {
    var titleLabelMaxX: CGFloat {
        return self.titleLabel.frame.maxX
    }
    
    var spacing: CGFloat {
        return 0
    }
}
