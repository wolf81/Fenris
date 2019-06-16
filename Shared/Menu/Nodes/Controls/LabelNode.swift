//
//  LabelNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 14/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

class LabelNode: SKShapeNode, MenuItemNode {
    let item: MenuItem
    
    private var labelItem: LabelItem { return self.item as! LabelItem }
    
    private let label: SKLabelNode

    public init(size: CGSize, item: LabelItem, font: Font) {
        self.item = item
        
        self.label = SKLabelNode()
        self.label.font = font
        self.label.position = CGPoint(x: size.width / 2, y: (size.height - font.capHeight) / 2)

        super.init()

        self.path = CGPath(rect: CGRect(origin: .zero, size: size), transform: nil)
        self.lineWidth = 0
        
        addChild(self.label)
        
        self.labelItem.addObserver(self, forKeyPath: #keyPath(LabelItem.title), options: [.initial, .new], context: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    deinit {
        self.labelItem.removeObserver(self, forKeyPath: #keyPath(LabelItem.title))
    }
    
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if object is LabelItem && keyPath == #keyPath(LabelItem.title) {
            self.label.text = self.labelItem.title
        }
    }
}
