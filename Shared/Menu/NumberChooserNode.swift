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
    
    private let label: SKLabelNode
    
    private let menuItem: NumberChooserMenuItem
    
    init(size: CGSize, font: Font, menuItem: NumberChooserMenuItem) {
        let buttonSize = CGSize(width: size.height / 3 * 2, height: size.height)
        self.minusSignButton = SignButtonNode(size: buttonSize, sign: .minus)
        self.plusSignButton = SignButtonNode(size: buttonSize, sign: .plus)
        
        self.menuItem = menuItem
        
        let title = "\(self.menuItem.selectedValue)"
        self.label = SKLabelNode(text: title)
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
        self.label.position = CGPoint(x: self.frame.midX, y: (self.frame.height - font.maxHeight) / 2)
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
        self.menuItem.selectedValue -= 1
        
        if self.menuItem.range.contains(self.menuItem.selectedValue) == false {
            self.menuItem.selectedValue = self.menuItem.range.min() ?? 0
        }
//        self.menuItem.selectedValueIdx -= 1
//        if self.menuItem.selectedValueIdx < 0 {
//            self.menuItem.selectedValueIdx = self.menuItem.values.count - 1
//        }
//        self.label.text = self.menuItem.values[self.menuItem.selectedValueIdx]
    }
    
    func right() {
        self.menuItem.selectedValue += 1

        if self.menuItem.range.contains(self.menuItem.selectedValue) == false {
            self.menuItem.selectedValue = self.menuItem.range.max() ?? 0
        }

//        self.menuItem.selectedValueIdx += 1
//        if self.menuItem.selectedValueIdx > (self.menuItem.values.count - 1) {
//            self.menuItem.selectedValueIdx = 0
//        }
//        self.label.text = self.menuItem.values[self.menuItem.selectedValueIdx]
    }
}
