//
//  TextChooserNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 13/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

class TextChooserNode: SKShapeNode, MenuItemNode {
    let item: MenuItem
    
    private var chooserItem: TextChooserItem { return self.item as! TextChooserItem }
    
    private let label: SKLabelNode
    private let leftArrowButton: ArrowButtonNode
    private let rightArrowButton: ArrowButtonNode
    
    var text: String? { return self.label.text }
    
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
        
        self.chooserItem.addObserver(self, forKeyPath: #keyPath(TextChooserItem.selectedValueIdx), options: [.initial, .new], context: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    deinit {
        self.chooserItem.removeObserver(self, forKeyPath: #keyPath(TextChooserItem.selectedValueIdx))
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if object is TextChooserItem && keyPath == #keyPath(TextChooserItem.selectedValueIdx) {
            let value = self.chooserItem.values.count > 0 ? self.chooserItem.values[self.chooserItem.selectedValueIdx] : nil
            self.label.text = value
        }
    }
}

// MARK: - InputDeviceInteractable

extension TextChooserNode: InputDeviceInteractable {
    func handleInput(action: InputDeviceAction) {
        let validActions: InputDeviceAction = [.left, .right]
        guard validActions.contains(action) else { return }
        
        let valueRange = (0 ..< self.chooserItem.values.count)
        
        switch action {
        case .left:
            let newValue = self.chooserItem.selectedValueIdx - 1
            if valueRange.contains(newValue) {
                self.chooserItem.selectedValueIdx = newValue
            } else {
                self.chooserItem.selectedValueIdx = (self.chooserItem.values.count - 1)
            }
        case .right:
            let newValue = self.chooserItem.selectedValueIdx + 1
            if valueRange.contains(newValue) {
                self.chooserItem.selectedValueIdx = newValue
            } else {
                self.chooserItem.selectedValueIdx = 0
            }
        default: /* Should never happen */ fatalError()
        }
    }
}
