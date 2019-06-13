//
//  MenuItemContainerNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 13/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

class MenuItemContainerNode: SKShapeNode {
    let menuItem: MenuItem

    var selected: Bool {
        didSet {
            print("change stroke color: \(self.selected)")
            self.strokeColor = self.selected ? .yellow : .clear
        }
    }
    
    init(menuItem: MenuItem, configuration: MenuConfiguration) {
        self.selected = true
        self.menuItem = menuItem

        super.init()

        self.lineWidth = 1
        
        let width = menuItem is ButtonMenuItem ? configuration.menuWidth / 2 : configuration.menuWidth
        
        let size = CGSize(width: width, height: configuration.itemHeight)
        self.path = CGPath(rect: CGRect(origin: .zero, size: size), transform: nil)
        
        let label = SKLabelNode(text: menuItem.title)
        addChild(label)
        
        if !(menuItem is ButtonMenuItem) {
            let chooser = ChooserNode(size: CGSize(width: configuration.menuWidth / 2, height: configuration.itemHeight))
            chooser.position = CGPoint(x: configuration.menuWidth / 2, y: (frame.height - chooser.frame.height) / 2)
            chooser.zPosition = -1
            addChild(chooser)
        }
        
        let labelX = (configuration.menuWidth / 2) / 2
        label.position = CGPoint(x: labelX, y: (frame.height - label.frame.height) / 2)
        self.selected = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
