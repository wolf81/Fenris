//
//  ChooserNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 13/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

class ChooserNode: SKShapeNode {
    private let leftArrowButton: ArrowButtonNode
    private let rightArrowButton: ArrowButtonNode
    
    init(size: CGSize) {
        let buttonSize = CGSize(width: size.height / 3 * 2, height: size.height)
        self.leftArrowButton = ArrowButtonNode(size: buttonSize, direction: .left)
        self.rightArrowButton = ArrowButtonNode(size: buttonSize, direction: .right)
        
        super.init()
        
        self.strokeColor = SKColor.white
        self.lineWidth = 1

        self.path = CGPath(rect: CGRect(origin: .zero, size: size), transform: nil)
                
        addChild(self.leftArrowButton)
        self.leftArrowButton.position = .zero
        
        addChild(self.rightArrowButton)
        self.rightArrowButton.position = CGPoint(x: size.width - buttonSize.width, y: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
