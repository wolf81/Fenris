//
//  ToggleNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 02/08/2018.
//  Copyright © 2018 Wolftrail. All rights reserved.
//

import SpriteKit

class ToggleNode: SKShapeNode, MenuNode {
    var titleLabelMaxX: CGFloat
        
    required init(option: Toggle) {
        self.titleLabel = SKLabelNode(text: option.title)
        self.titleLabel.horizontalAlignmentMode = .left
        self.titleLabel.verticalAlignmentMode = .center
        
        let labelFrame = self.titleLabel.calculateAccumulatedFrame()
        let h = labelFrame.height
        
        self.toggle = SKShapeNode(ellipseOf: CGSize(width: h / 2, height: h / 2))
        self.toggle.strokeColor = .white
        self.toggle.fillColor = .white
        
        self.titleLabelMaxX = labelFrame.maxX
        
        super.init()
        
        let toggleFrame = self.toggle.calculateAccumulatedFrame()
        let w = labelFrame.width + self.spacing + toggleFrame.width
        
        self.path = CGPath(rect: CGRect(x: 0, y: 0, width: w, height: h), transform: nil)
        self.toggle.position = CGPoint(x: w - self.toggle.frame.width / 2, y: h / 2)
        self.titleLabel.position = CGPoint(x: 0, y: h / 2)
        
        addChild(self.titleLabel)
        addChild(self.toggle)
        
        self.checked = option.checked
        
        self.strokeColor = SKColor.clear
    }
    
    var titleLabel: SKLabelNode
    var toggle: SKShapeNode
    
    var checked: Bool = false {
        didSet {
            self.toggle.fillColor = self.checked ? SKColor.white : SKColor.clear
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func calculateAccumulatedFrame() -> CGRect {
        let labelFrame = self.titleLabel.calculateAccumulatedFrame()
        let toggleFrame = self.toggle.calculateAccumulatedFrame()

        let w = labelFrame.width + spacing + toggleFrame.width
        let h = fmax(toggleFrame.height, labelFrame.height)
        
        return CGRect(x: 0, y: 0, width: w, height: h)
    }
}

//extension ToggleNode: MenuNode {
//    var titleLabelMaxX: CGFloat {
//        return self.titleLabel.calculateAccumulatedFrame().maxX
//    }
//
//    var spacing: CGFloat {
//        return 30
//    }
//}
