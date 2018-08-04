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
    private var toggle: SKShapeNode
    private var height: CGFloat
    
    required init(option: Toggle, height: CGFloat) throws {
        self.option = option
        self.height = height
        
        self.label = SKLabelNode(text: option.title)
        self.label.horizontalAlignmentMode = .left
        self.label.verticalAlignmentMode = .center
        
        let labelFrame = self.label.calculateAccumulatedFrame()
        let h = height
        
        let font = try Font(name: self.label.fontName!, size: self.label.fontSize)        
        let diff = font.maxHeight - (label.calculateAccumulatedFrame().height / 2)

        self.toggle = SKShapeNode(ellipseOf: CGSize(width: font.xHeight, height: font.xHeight))
        self.toggle.strokeColor = .white
        
        self.titleLabelMaxX = labelFrame.maxX
        
        super.init()
        
        let toggleFrame = self.toggle.calculateAccumulatedFrame()
        let w = labelFrame.width + self.spacing + toggleFrame.width
        
        self.path = CGPath(rect: CGRect(x: 0, y: 0, width: w, height: h), transform: nil)
        self.toggle.position = CGPoint(x: w - self.toggle.frame.width / 2, y: h / 2 + titleYOffset)        
        self.label.position = CGPoint(x: 0, y: diff + self.titleYOffset)

        addChild(self.label)
        addChild(self.toggle)
        
        self.strokeColor = .clear
        
        updateForCurrentState()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func calculateAccumulatedFrame() -> CGRect {
        let labelFrame = self.label.calculateAccumulatedFrame()
        let toggleFrame = self.toggle.calculateAccumulatedFrame()

        let w = labelFrame.width + spacing + toggleFrame.width
        let h = self.height
        
        return CGRect(x: 0, y: 0, width: w, height: h)
    }

    // MARK: - MenuNode
    
    var titleLabelMaxX: CGFloat

    func interact(location: CGPoint) {
        if self.toggle.calculateAccumulatedFrame().contains(location) {
            self.option.checked = !self.option.checked
            updateForCurrentState()
        }
    }
    
    // MARK: - Private
    
    private func updateForCurrentState() {
        self.toggle.fillColor = self.option.checked ? .white : .clear
    }    
}
