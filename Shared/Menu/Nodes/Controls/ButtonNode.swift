//
//  ButtonNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 15/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

class ButtonNode: SKShapeNode, MenuItemNode, CustomStringConvertible {
    let item: MenuItem
    
    private var buttonItem: ButtonItem { return self.item as! ButtonItem }
        
    init(size: CGSize, item: ButtonItem, font: Font) {
        self.item = item
        
        super.init()

        self.path = CGPath(rect: CGRect(origin: .zero, size: size), transform: nil)
        self.lineWidth = 1
        
        addChild(self.label)
        
        self.buttonItem.addObserver(self, forKeyPath: #keyPath(ButtonItem.title), options: [.initial, .new], context: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    deinit {
        self.buttonItem.removeObserver(self, forKeyPath: #keyPath(ButtonItem.title))
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if object is ButtonItem && keyPath == #keyPath(ButtonItem.title) {
            self.label.text = self.buttonItem.title
        }
    }
}

// MARK: - InputDeviceInteractable

extension ButtonNode: InputDeviceInteractable {
    func handleKeyUp(action: KeyboardAction) {
        self.buttonItem.onClick?()
    }

    func handleInput(action: GameControllerAction) {
        let validActions: GameControllerAction = [.buttonA, .buttonB]
        if validActions.contains(action) {
            self.buttonItem.onClick?()
        }
    }

    func handleMouseMoved(location: CGPoint) {
        
    }
    
    func handleMouseUp(location: CGPoint) {
        self.buttonItem.onClick?()
    }
}
