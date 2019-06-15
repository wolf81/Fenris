//
//  NumberChooserNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 14/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

class NumberChooserNode: SKShapeNode {
    private let minusSignButton: SignButtonNode
    private let plusSignButton: SignButtonNode
    
    private let label: SKLabelNode = SKLabelNode()
    
    private let item: NumberChooserItem
    
    init(size: CGSize, item: NumberChooserItem, font: Font) {
        self.item = item
        
        let buttonSize = CGSize(width: size.height / 3 * 2, height: size.height)
        
        self.minusSignButton = SignButtonNode(size: buttonSize, sign: .minus)
        self.minusSignButton.position = .zero

        self.plusSignButton = SignButtonNode(size: buttonSize, sign: .plus)
        self.plusSignButton.position = CGPoint(x: size.width - buttonSize.width, y: 0)

        self.label.font = font
        self.label.position = CGPoint(x: size.width / 2, y: (size.height - font.capHeight) / 2)

        super.init()
        
        self.path = CGPath(rect: CGRect(origin: .zero, size: size), transform: nil)
        self.lineWidth = 0
        
        addChild(self.minusSignButton)
        addChild(self.plusSignButton)
        addChild(self.label)
        
        self.item.addObserver(self, forKeyPath: #keyPath(NumberChooserItem.selectedValue), options: [.initial, .new], context: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    deinit {
        self.item.removeObserver(self, forKeyPath: #keyPath(NumberChooserItem.selectedValue))
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if object is NumberChooserItem && keyPath == #keyPath(NumberChooserItem.selectedValue) {
            self.label.text = "\(self.item.selectedValue)"
        }
    }

    /*
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
        self.item.selectedValue -= 1
        
        if self.item.range.contains(self.item.selectedValue) == false {
            self.item.selectedValue = self.item.range.min() ?? 0
        }
    }
    
    func right() {
        self.item.selectedValue += 1

        if self.item.range.contains(self.item.selectedValue) == false {
            self.item.selectedValue = self.item.range.max() ?? 0
        }
    }
    */
}
