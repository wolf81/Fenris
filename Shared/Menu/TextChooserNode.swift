//
//  TextChooserNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 13/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

class TextChooserNode: SKShapeNode, MenuItemNode {
    let item: Item
    
    private var chooserItem: TextChooserItem { return self.item as! TextChooserItem }
    
    private let label: SKLabelNode
    private let leftArrowButton: ArrowButtonNode
    private let rightArrowButton: ArrowButtonNode

    init(size: CGSize, item: TextChooserItem, font: Font) {
        let buttonSize = CGSize(width: size.height / 3 * 2, height: size.height)
        
        self.leftArrowButton = ArrowButtonNode(size: buttonSize, direction: .left)
        self.leftArrowButton.position = .zero

        self.rightArrowButton = ArrowButtonNode(size: buttonSize, direction: .right)
        self.rightArrowButton.position = CGPoint(x: size.width - buttonSize.width, y: 0)

        self.item = item
        
        self.label = SKLabelNode(text: nil)
        self.label.position = CGPoint(x: size.width / 2, y: (size.height - font.capHeight) / 2)
        self.label.font = font
        
        super.init()
        
        self.path = CGPath(rect: CGRect(origin: .zero, size: size), transform: nil)
        self.lineWidth = 0
        
        addChild(self.leftArrowButton)
        addChild(self.rightArrowButton)
        addChild(self.label)
        
        self.chooserItem.addObserver(self, forKeyPath: #keyPath(TextChooserItem.selectedValue), options: [.initial, .new], context: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    deinit {
        self.chooserItem.removeObserver(self, forKeyPath: #keyPath(TextChooserItem.selectedValue))
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if object is TextChooserItem && keyPath == #keyPath(TextChooserItem.selectedValue) {
            self.label.text = self.chooserItem.selectedValue
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
        if self.item.selectedValueIdx - 1 >= 0 {
            self.item.selectedValueIdx -= 1
        } else {
            self.item.selectedValueIdx = (self.menuItem.values.count - 1)
        }
    }
    
    func right() {
        if self.item.selectedValueIdx + 1 < self.menuItem.values.count {
            self.item.selectedValueIdx += 1
        } else {
            self.item.selectedValueIdx = 0
        }
    }
     */
}
