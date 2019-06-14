//
//  DetailLabelNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 14/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

class DetailLabelNode: SKShapeNode {
    private let menuItem: LabelMenuItem
    
    private let label: SKLabelNode = SKLabelNode()
    
    init(size: CGSize, font: Font, menuItem: LabelMenuItem) {
        self.menuItem = menuItem

        super.init()        

        self.path = CGPath(rect: CGRect(origin: .zero, size: size), transform: nil)
        self.strokeColor = .clear
        self.lineWidth = 0

        addChild(label)

        self.label.font = font
        self.label.position = CGPoint(x: size.width / 2, y: (size.height - font.capHeight) / 2)
        
        self.menuItem.addObserver(self, forKeyPath: #keyPath(LabelMenuItem.value), options: [.initial, .new], context: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    deinit {
        self.menuItem.removeObserver(self, forKeyPath: #keyPath(LabelMenuItem.value))
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if object is LabelMenuItem && keyPath == #keyPath(LabelMenuItem.value) {
            self.label.text = "\(self.menuItem.value)"
        }
    }
}
