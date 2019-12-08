//
//  ToggleNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 13/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

class ToggleNode: SKShapeNode, MenuItemNode {
    let item: MenuItem

    private var toggleItem: ToggleItem { return self.item as! ToggleItem }
    
    private let label: SKLabelNode
    fileprivate let leftArrowButton: ArrowButtonNode
    fileprivate let rightArrowButton: ArrowButtonNode
    
    var text: String? { return self.label.text }

    init(size: CGSize, item: ToggleItem, font: Font) {
        self.item = item
        
        let buttonSize = CGSize(width: size.height / 3 * 2, height: size.height)

        self.leftArrowButton = ArrowButtonNode(size: buttonSize, direction: .left)
        self.leftArrowButton.position = .zero

        self.rightArrowButton = ArrowButtonNode(size: buttonSize, direction: .right)
        self.rightArrowButton.position = CGPoint(x: size.width - buttonSize.width, y: 0)

        self.label = SKLabelNode()
        self.label.font = font
        self.label.position = CGPoint(x: size.width / 2, y: (size.height - font.capHeight) / 2)

        super.init()
        
        self.path = CGPath(rect: CGRect(origin: .zero, size: size), transform: nil)
        self.lineWidth = 0
        
        addChild(self.leftArrowButton)
        addChild(self.rightArrowButton)
        addChild(self.label)
        
        self.toggleItem.addObserver(self, forKeyPath: #keyPath(ToggleItem.isEnabled), options: [.initial, .new], context: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    deinit {
        self.toggleItem.removeObserver(self, forKeyPath: #keyPath(ToggleItem.isEnabled))
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if object is ToggleItem && keyPath == #keyPath(ToggleItem.isEnabled) {
            self.label.text = self.toggleItem.isEnabled ? "On" : "Off"
            
            self.toggleItem.onValueChanged?(self.toggleItem.isEnabled)
        }
    }
    
    fileprivate func toggle() {
        self.toggleItem.isEnabled = !self.toggleItem.isEnabled
    }
}

// MARK: - InputDeviceInteractable

extension ToggleNode: InputDeviceInteractable {
    func handleInput(action: GameControllerAction) {
        let validActions: GameControllerAction = [.left, .right]
        guard validActions.contains(action) else { return }
        
        toggle()
    }
    
    func handleMouseUp(location: CGPoint) {
        if self.leftArrowButton.contains(location) || self.rightArrowButton.contains(location) {
            toggle()
        }
    }
    
    func handleMouseMoved(location: CGPoint) {
        
    }
    
    func handleKeyUp(action: KeyboardAction) {
        let validActions: KeyboardAction = [.left, .right]
        guard validActions.contains(action) else { return }
        
        toggle()
    }
}
