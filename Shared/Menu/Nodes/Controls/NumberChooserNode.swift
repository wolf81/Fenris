//
//  NumberChooserNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 14/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

class NumberChooserNode: SKShapeNode, MenuItemNode {
    let item: MenuItem
    
    var chooserItem: NumberChooserItem { return self.item as! NumberChooserItem }
    
    private let label: SKLabelNode
    private let minusSignButton: SignButtonNode
    private let plusSignButton: SignButtonNode

    init(size: CGSize, item: NumberChooserItem, font: Font) {
        self.item = item
        
        let buttonSize = CGSize(width: size.height / 3 * 2, height: size.height)
        
        self.minusSignButton = SignButtonNode(size: buttonSize, sign: .minus)
        self.minusSignButton.position = .zero

        self.plusSignButton = SignButtonNode(size: buttonSize, sign: .plus)
        self.plusSignButton.position = CGPoint(x: size.width - buttonSize.width, y: 0)

        self.label = SKLabelNode()
        self.label.font = font
        self.label.position = CGPoint(x: size.width / 2, y: (size.height - font.capHeight) / 2)

        super.init()
        
        self.path = CGPath(rect: CGRect(origin: .zero, size: size), transform: nil)
        self.lineWidth = 0
        
        addChild(self.minusSignButton)
        addChild(self.plusSignButton)
        addChild(self.label)
        
        self.chooserItem.addObserver(self, forKeyPath: #keyPath(NumberChooserItem.selectedValue), options: [.initial, .new], context: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    deinit {
        self.chooserItem.removeObserver(self, forKeyPath: #keyPath(NumberChooserItem.selectedValue))
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if object is NumberChooserItem && keyPath == #keyPath(NumberChooserItem.selectedValue) {
            self.label.text = "\(self.chooserItem.selectedValue)"
        }
    }
}

// MARK: - InputDeviceInteractable

extension NumberChooserNode: InputDeviceInteractable {
    func handleInput(action: InputDeviceAction) {
        let validActions: InputDeviceAction = [.left, .right]
        guard validActions.contains(action) else { return }
        
        switch action {
        case .left:
            let newValue = self.chooserItem.selectedValue - 1
            if self.chooserItem.range.contains(newValue) {
                self.chooserItem.selectedValue = newValue
            }
        case .right:
            let newValue = self.chooserItem.selectedValue + 1
            if self.chooserItem.range.contains(newValue) {
                self.chooserItem.selectedValue = newValue
            }
        default: /* Should never happen */ fatalError()
        }
    }
}
