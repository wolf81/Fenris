//
//  ToggleNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 13/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

class ToggleNode: SKShapeNode & SceneInteractable {
    private let leftArrowButton: ArrowButtonNode
    private let rightArrowButton: ArrowButtonNode
    
    private let label: SKLabelNode

    private let menuItem: ToggleMenuItem
    
    init(size: CGSize, font: Font, menuItem: ToggleMenuItem) {
        self.menuItem = menuItem
        
        let buttonSize = CGSize(width: size.height / 3 * 2, height: size.height)
        self.leftArrowButton = ArrowButtonNode(size: buttonSize, direction: .left)
        self.rightArrowButton = ArrowButtonNode(size: buttonSize, direction: .right)
        
        self.label = SKLabelNode(text: "-")
        self.label.font = font

        super.init()
        
        self.strokeColor = SKColor.clear
        self.lineWidth = 0
        
        self.path = CGPath(rect: CGRect(origin: .zero, size: size), transform: nil)
        
        addChild(self.leftArrowButton)
        self.leftArrowButton.position = .zero
        
        addChild(self.rightArrowButton)
        self.rightArrowButton.position = CGPoint(x: size.width - buttonSize.width, y: 0)
        
        addChild(self.label)
        self.label.position = CGPoint(x: self.frame.midX, y: (self.frame.height - font.maxHeight) / 2)

        updateLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    func up() {
        // ignore
    }
    
    func down() {
        // ignore
    }
    
    func left() {
        self.menuItem.isEnabled = !self.menuItem.isEnabled
        updateLabel()
    }
    
    func right() {
        self.menuItem.isEnabled = !self.menuItem.isEnabled
        updateLabel()
    }
    
    private func updateLabel() {
        self.label.text = self.menuItem.isEnabled ? "On" : "Off"
    }
}
