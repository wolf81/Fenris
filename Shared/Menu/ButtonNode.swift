//
//  ButtonNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 15/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

class ButtonNode: SKShapeNode, MenuItemNode {
    let item: Item
    
    private var buttonItem: ButtonItem { return self.item as! ButtonItem }
    
    private let label: SKLabelNode
    
    init(size: CGSize, item: ButtonItem, font: Font) {
        self.item = item
        
        self.label = SKLabelNode()
        self.label.font = font
        self.label.position = CGPoint(x: size.width / 2, y: (size.height - font.capHeight) / 2)

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
