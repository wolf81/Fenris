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
    
    private var label: SKLabelNode
    private var button: ButtonNode!
    
    private var preferredButtonSize: CGSize = .zero
    
    private var size: CGSize {
        let labelFrame = self.label.calculateAccumulatedFrame()
        let buttonFrame = self.button.calculateAccumulatedFrame()
        
        let w = labelFrame.width + self.spacing + buttonFrame.width
        let h = self.option.configuration.height

        return CGSize(width: w, height: h)
    }
    
    required init(option: Chooser) throws {
        self.option = option
        
        self.label = SKLabelNode(text: option.title)
        self.label.font = option.configuration.font
        self.label.horizontalAlignmentMode = .left
        self.label.verticalAlignmentMode = .baseline

        let font = Font(name: self.label.fontName!, size: self.label.fontSize)!
        let yOffset = ((self.option.configuration.height - font.maxHeight) / 2) +
            self.option.configuration.labelYOffset
        
        super.init()

        self.preferredButtonSize = maximumButtonSizeForOptionValues()
        try updateForCurrentState()
        
        updatePath()
        
        addChild(self.label)

        self.label.position = CGPoint(x: 0, y: yOffset)

        self.strokeColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func calculateAccumulatedFrame() -> CGRect {
        return CGRect(origin: .zero, size: self.size)
    }
    
    // MARK: - MenuNode

    var titleLabelMaxX: CGFloat {
        return self.label.calculateAccumulatedFrame().maxX
    }

    func interact(location: CGPoint) {
        let location = self.convert(location, to: self.button)
        if self.button.calculateAccumulatedFrame().contains(location) {
            self.option.selectNextValue()

            try! updateForCurrentState()
        }
    }
    
    // MARK: - Private
    
    private func updateForCurrentState() throws {
        if let button = self.button {
            button.removeFromParent()
        }
        
        self.button = try ButtonNode(
            option: Button(
                title: self.option.value,
                configuration: self.option.configuration
            ),
            width: self.preferredButtonSize.width
        )
        self.addChild(self.button)
        
        updateButtonPosition()
    }
    
    private func updateButtonPosition() {
        let buttonFrame = self.button.calculateAccumulatedFrame()
        
        self.button.position = CGPoint(
            x: self.size.width - buttonFrame.width,
            y: (self.size.height - buttonFrame.height) / 2
        )
    }
    
    private func updatePath() {
        self.path = CGPath(
            rect: CGRect(origin: .zero, size: self.size),
            transform: nil
        )
    }
    
    private func maximumButtonSizeForOptionValues() -> CGSize {
        var maximumSize: CGSize = CGSize(width: 0, height: 30)
        
        for value in self.option.values {
            do {
                let button = try ButtonNode(
                    option: Button(
                        title: value,
                        configuration: self.option.configuration
                    ),
                    width: preferredButtonSize.width
                )
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
