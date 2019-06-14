//
//  TextButtonNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 14/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

class TextButtonNode: SKShapeNode & SceneInteractable {
    private let menuItem: ButtonMenuItem
    
    private let label: SKLabelNode
    
    init(size: CGSize, font: Font, menuItem: ButtonMenuItem) {
        self.menuItem = menuItem
        
        self.label = SKLabelNode(text: menuItem.title)
        
        super.init()
        
        self.path = CGPath(rect: CGRect(origin: .zero, size: size), transform: nil)
        self.strokeColor = .clear
        self.lineWidth = 0

        self.label.font = font
        self.label.position = CGPoint(x: size.width / 2, y: (size.height - font.capHeight) / 2)
        
        addChild(self.label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func action() {
         self.menuItem.onClick()
    }
    
    func up() {
        // ignore
    }
    
    func down() {
        // ignore
    }
    
    func left() {
        // ignore
    }
    
    func right() {
        // ignore
    }
}
