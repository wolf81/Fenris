//
//  ToggleNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 02/08/2018.
//  Copyright © 2018 Wolftrail. All rights reserved.
//

import SpriteKit

class ToggleNode: SKShapeNode, MenuNode {    
    private var option: Toggle

    private var label: SKLabelNode
    private var outline: SKShapeNode
    private var check: SKShapeNode
    
    required init(option: Toggle) throws {
        self.option = option
        
        self.label = SKLabelNode(text: option.title)
        self.label.font = option.configuration.font
        self.label.horizontalAlignmentMode = .left
        self.label.verticalAlignmentMode = .baseline
        
        let labelFrame = self.label.calculateAccumulatedFrame()
        let h = self.option.configuration.height
        
        let font = try Font(name: self.label.fontName!, size: self.label.fontSize)        
        let yOffset = ((self.option.configuration.height - font.maxHeight) / 2) +
            self.option.configuration.labelYOffset

        self.outline = SKShapeNode(ellipseOf: CGSize(width: font.xHeight, height: font.xHeight))
        self.outline.strokeColor = .white
        self.outline.fillColor = .clear
        
        self.check = SKShapeNode(ellipseOf: CGSize(width: font.xHeight - 4, height: font.xHeight - 4))
        self.check.strokeColor = .clear
        self.check.fillColor = .white
        self.check.isAntialiased = true
        
        self.titleLabelMaxX = labelFrame.maxX
        
        super.init()
        
        let toggleFrame = self.outline.calculateAccumulatedFrame()
        let checkFrame = self.check.calculateAccumulatedFrame()
        let w = labelFrame.width + self.spacing + toggleFrame.width
        
        self.path = CGPath(rect: CGRect(x: 0, y: 0, width: w, height: h), transform: nil)
        self.outline.position = CGPoint(x: w - self.outline.frame.width / 2,
                                       y: yOffset + toggleFrame.height / 2)
        self.check.position = CGPoint(x: w - self.outline.frame.width / 2,
                                        y: yOffset + toggleFrame.height / 2)
        self.label.position = CGPoint(x: 0, y: yOffset)

        addChild(self.label)
        addChild(self.outline)
        addChild(self.check)
        
        self.strokeColor = .clear
        
        updateForCurrentState()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func calculateAccumulatedFrame() -> CGRect {
        let labelFrame = self.label.calculateAccumulatedFrame()
        let toggleFrame = self.outline.calculateAccumulatedFrame()

        let w = labelFrame.width + spacing + toggleFrame.width
        let h = self.option.configuration.height
        
        return CGRect(x: 0, y: 0, width: w, height: h)
    }

    // MARK: - MenuNode
    
    var titleLabelMaxX: CGFloat

    func interact(location: CGPoint) {
        if self.outline.calculateAccumulatedFrame().contains(location) {
            self.option.checked = !self.option.checked
            updateForCurrentState()
        }
    }
    
    // MARK: - Private
    
    private func updateForCurrentState() {
        self.check.isHidden = self.option.checked == false
    }
}
