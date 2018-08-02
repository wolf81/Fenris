//
//  NumberPickerNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 02/08/2018.
//  Copyright © 2018 Wolftrail. All rights reserved.
//

import SpriteKit

class NumberPickerNode: SKShapeNode, MenuNode {
    var titleLabelMaxX: CGFloat
    
    var titleLabel: SKLabelNode
    var valueLabel: SKLabelNode

    let range: Range<Int>
    var value: Int = 0 {
        didSet {
            self.valueLabel.text = String(self.value)
        }
    }
    
    required init(option: NumberPicker) {
        self.range = option.range
        self.value = option.value

        self.titleLabel = SKLabelNode(text: option.title)
        self.titleLabel.horizontalAlignmentMode = .left
        self.titleLabel.verticalAlignmentMode = .center
        
        let titleLabelFrame = self.titleLabel.calculateAccumulatedFrame()
        let h = titleLabelFrame.height
        
        self.valueLabel = SKLabelNode(text: "\(option.value)")
        self.valueLabel.horizontalAlignmentMode = .left
        self.valueLabel.verticalAlignmentMode = .center
        
        let valueLabelFrame = self.valueLabel.calculateAccumulatedFrame()
        self.titleLabelMaxX = titleLabelFrame.maxX
        
        super.init()
        
        let w = titleLabelFrame.width + self.spacing + valueLabelFrame.width
        self.path = CGPath(rect: CGRect(x: 0, y: 0, width: w, height: h), transform: nil)
        
        self.titleLabel.position = CGPoint(x: 0, y: h / 2)
        self.valueLabel.position = CGPoint(x: w - valueLabelFrame.width, y: h / 2)
        
        addChild(titleLabel)
        addChild(valueLabel)
        
        self.strokeColor = SKColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func calculateAccumulatedFrame() -> CGRect {
        let titleLabelFrame = self.titleLabel.calculateAccumulatedFrame()
        let valueLabelFrame = self.valueLabel.calculateAccumulatedFrame()
        
        let w = titleLabelFrame.width + spacing + valueLabelFrame.width
        let h = fmax(valueLabelFrame.height, titleLabelFrame.height)
        
        return CGRect(x: 0, y: 0, width: w, height: h)
    }
}
