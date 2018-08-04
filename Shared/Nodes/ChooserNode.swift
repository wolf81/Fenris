//
//  ChooserNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 02/08/2018.
//  Copyright © 2018 Wolftrail. All rights reserved.
//

import SpriteKit

class ChooserNode: SKShapeNode, MenuNode {
    private var option: Chooser
    private var height: CGFloat
    
    private var label: SKLabelNode
    private var button: ButtonNode!
    
    private var preferredButtonSize: CGSize = .zero
    
    required init(option: Chooser, height: CGFloat) throws {
        self.height = height
        self.option = option
        
        self.label = SKLabelNode(text: option.title)
        self.label.horizontalAlignmentMode = .left
        self.label.verticalAlignmentMode = .center

        let font = try Font(name: self.label.fontName!, size: self.label.fontSize)
        let diff = font.maxHeight - (label.calculateAccumulatedFrame().height / 2)

        let labelFrame = self.label.calculateAccumulatedFrame()
        
        self.titleLabelMaxX = labelFrame.maxX
        
        super.init()

        self.preferredButtonSize = maximumButtonSizeForOptionValues()
        self.button = try ButtonNode(option: Button(title: option.value), height: height, width: preferredButtonSize.width)
        
        self.label.position = CGPoint(x: 0, y: diff + self.titleYOffset)

        updatePath()
        updateButtonPosition()
        
        addChild(self.label)
        addChild(self.button)
        
        self.strokeColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func calculateAccumulatedFrame() -> CGRect {
        let labelFrame = self.label.calculateAccumulatedFrame()
        let buttonFrame = self.button.calculateAccumulatedFrame()
        
        let w = labelFrame.width + spacing + buttonFrame.width
        let h = self.height
        
        return CGRect(x: 0, y: 0, width: w, height: h)
    }
    
    // MARK: - MenuNode

    var titleLabelMaxX: CGFloat

    func interact(location: CGPoint) {
        let location = self.convert(location, to: self.button)
        if self.button.calculateAccumulatedFrame().contains(location) {
            self.option.selectNextValue()

            self.button.removeFromParent()
            self.button = try! ButtonNode(option: Button(title: option.value), height: self.height, width: preferredButtonSize.width)
            self.addChild(self.button)
            
            updatePath()
            updateButtonPosition()
        }
    }
    
    // MARK: - Private
    
    private func updateButtonPosition() {
        let labelFrame = self.label.calculateAccumulatedFrame()
        let buttonFrame = self.button.calculateAccumulatedFrame()
        let buttonWidth = buttonFrame.width

        let w = labelFrame.width + spacing + buttonWidth
        let h = height
        
        self.button.position = CGPoint(x: w - buttonWidth, y: (h - buttonFrame.height) / 2)
    }
    
    private func updatePath() {
        let labelFrame = self.label.calculateAccumulatedFrame()
        let buttonFrame = self.button.calculateAccumulatedFrame()

        let w = labelFrame.width + self.spacing + buttonFrame.width
        let h = self.height

        self.path = CGPath(rect: CGRect(x: 0, y: 0, width: w, height: h), transform: nil)
    }
    
    private func maximumButtonSizeForOptionValues() -> CGSize {
        var maximumSize: CGSize = CGSize(width: 0, height: 30)
        
        for value in self.option.values {
            do {
                let button = try ButtonNode(option: Button(title: value), height: self.height, width: preferredButtonSize.width)
                let width = button.calculateAccumulatedFrame().width
                if width > maximumSize.width {
                    maximumSize.width = width
                }
            } catch let error {
                print("[ERROR] \(error.localizedDescription)")
            }
        }
        
        return maximumSize
    }
}
