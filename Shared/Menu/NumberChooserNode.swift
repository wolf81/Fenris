//
//  NumberChooserNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 14/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

class NumberChooserNode: SKShapeNode & SceneInteractable {
    private let minusSignButton: SignButtonNode
    private let plusSignButton: SignButtonNode
    
    private let label: SKLabelNode = SKLabelNode()
    
    private let menuItem: NumberChooserMenuItem
    
    init(size: CGSize, font: Font, menuItem: NumberChooserMenuItem) {
        let buttonSize = CGSize(width: size.height / 3 * 2, height: size.height)
        self.minusSignButton = SignButtonNode(size: buttonSize, sign: .minus)
        self.plusSignButton = SignButtonNode(size: buttonSize, sign: .plus)
        
        self.menuItem = menuItem
        
        self.label.font = font
        
        super.init()
        
        self.strokeColor = SKColor.clear
        self.lineWidth = 0
        
        self.path = CGPath(rect: CGRect(origin: .zero, size: size), transform: nil)
        
        addChild(self.minusSignButton)
        self.minusSignButton.position = .zero
        
        addChild(self.plusSignButton)
        self.plusSignButton.position = CGPoint(x: size.width - buttonSize.width, y: 0)
        
        addChild(self.label)
        self.label.position = CGPoint(x: self.frame.midX, y: (size.height - font.capHeight) / 2)
        
        self.menuItem.addObserver(self, forKeyPath: #keyPath(NumberChooserMenuItem.selectedValue), options: [.initial, .new], context: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    deinit {
        self.menuItem.removeObserver(self, forKeyPath: #keyPath(NumberChooserMenuItem.selectedValue))
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if object is NumberChooserMenuItem && keyPath == #keyPath(NumberChooserMenuItem.selectedValue) {
            self.label.text = "\(self.menuItem.selectedValue)"
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
        self.menuItem.selectedValue -= 1
        
        if self.menuItem.range.contains(self.menuItem.selectedValue) == false {
            self.menuItem.selectedValue = self.menuItem.range.min() ?? 0
        }
    }
    
    func right() {
        self.menuItem.selectedValue += 1

        if self.menuItem.range.contains(self.menuItem.selectedValue) == false {
            self.menuItem.selectedValue = self.menuItem.range.max() ?? 0
        }
    }
}
