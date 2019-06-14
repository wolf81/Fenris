//
//  ChooserNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 13/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

class ChooserNode: SKShapeNode & SceneInteractable {
    private let leftArrowButton: ArrowButtonNode
    private let rightArrowButton: ArrowButtonNode
    
    private let label: SKLabelNode
    
    private let menuItem: ChooserMenuItem
    
    init(size: CGSize, font: Font, menuItem: ChooserMenuItem) {
        let buttonSize = CGSize(width: size.height / 3 * 2, height: size.height)
        self.leftArrowButton = ArrowButtonNode(size: buttonSize, direction: .left)
        self.rightArrowButton = ArrowButtonNode(size: buttonSize, direction: .right)

        self.menuItem = menuItem
        
        self.label = SKLabelNode(text: nil)
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
        self.label.position = CGPoint(x: self.frame.midX, y: (size.height - font.capHeight) / 2)
        
        self.menuItem.addObserver(self, forKeyPath: #keyPath(ChooserMenuItem.selectedValueIdx), options: [.initial, .new], context: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    deinit {
        self.menuItem.removeObserver(self, forKeyPath: #keyPath(ChooserMenuItem.selectedValueIdx))
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if object is ChooserMenuItem && keyPath == #keyPath(ChooserMenuItem.selectedValueIdx) {
            self.label.text = self.menuItem.values[self.menuItem.selectedValueIdx]
        }
    }
    
    func action() {
        // ignore
    }
    
    func up() {
        // ignore
    }
    
    func down() {
        // ignore
    }
    
    func left() {
        if self.menuItem.selectedValueIdx - 1 >= 0 {
            self.menuItem.selectedValueIdx -= 1
        } else {
            self.menuItem.selectedValueIdx = (self.menuItem.values.count - 1)
        }
    }
    
    func right() {
        if self.menuItem.selectedValueIdx + 1 < self.menuItem.values.count {
            self.menuItem.selectedValueIdx += 1
        } else {
            self.menuItem.selectedValueIdx = 0
        }
    }
}
