//
//  NumberPickerNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 02/08/2018.
//  Copyright © 2018 Wolftrail. All rights reserved.
//

import SpriteKit

class NumberPickerNode: SKShapeNode {
    var titleLabel: SKLabelNode
    var valueLabel: SKLabelNode

    let range: Range<Int>
    var value: Int {
        didSet {
            self.valueLabel.text = String(self.value)
        }
    }
    
    init(title: String, range: Range<Int>, value: Int) {
        self.range = range
        self.value = range.lowerBound
        
        self.titleLabel = SKLabelNode(text: title)
        self.titleLabel.horizontalAlignmentMode = .left
        self.titleLabel.verticalAlignmentMode = .center
        
        let titleLabelFrame = self.titleLabel.calculateAccumulatedFrame()
        let h = titleLabelFrame.height

        self.valueLabel = SKLabelNode(text: "\(value)")
        self.valueLabel.horizontalAlignmentMode = .left
        self.valueLabel.verticalAlignmentMode = .center

        let valueLabelFrame = self.valueLabel.calculateAccumulatedFrame()
        
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

extension NumberPickerNode: TitleAlignableNode {
    var titleLabelMaxX: CGFloat {
        return self.titleLabel.calculateAccumulatedFrame().maxX
    }
    
    var spacing: CGFloat {
        return 30
    }
}


