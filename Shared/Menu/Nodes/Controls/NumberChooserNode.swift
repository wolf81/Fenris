//
//  NumberChooserNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 14/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

class NumberChooserNode: SKShapeNode, MenuItemNode, InputDeviceInteractable {
    var actions: InputDeviceAction = .none
    
    let item: MenuItem
    
    private var chooserItem: NumberChooserItem { return self.item as! NumberChooserItem }
    
    private let label: SKLabelNode
    fileprivate let minusSignButton: SignButtonNode
    fileprivate let plusSignButton: SignButtonNode
    
    var text: String? { return label.text }

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
    
    fileprivate func decrement() {
        let newValue = self.chooserItem.selectedValue - 1
        if self.chooserItem.range.contains(newValue) {
            self.chooserItem.selectedValue = newValue
        }
    }
    
    fileprivate func increment() {
        let newValue = self.chooserItem.selectedValue + 1
        if self.chooserItem.range.contains(newValue) {
            self.chooserItem.selectedValue = newValue
        }
    }
    
    func handlePress(_ action: InputDeviceAction) {
        //
    }
    
    func handleRelease(_ action: InputDeviceAction) {
        //
    }
}

// MARK: - InputDeviceInteractable

/*
extension NumberChooserNode: InputDeviceInteractable {
    func handleInput(action: GameControllerAction) {
        let validActions: GameControllerAction = [.left, .right]
        guard validActions.contains(action) else { return }
        
        switch action {
        case .left: decrement()
        case .right: increment()
        default: /* Should never happen */ fatalError()
        }
    }
    
    func handleMouseUp(location: CGPoint) {
        if self.minusSignButton.contains(location) {
            decrement()
        } else if self.plusSignButton.contains(location) {
            increment()
        }
    }
    
    func handleMouseMoved(location: CGPoint) {
        
    }

    func handleKeyUp(action: KeyboardAction) {
        let validActions: KeyboardAction = [.left, .right]
        guard validActions.contains(action) else { return }
        
        switch action {
        case .left: decrement()
        case .right: increment()
        default: /* Should never happen */ fatalError()
        }
    }
}
 */
