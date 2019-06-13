//
//  MenuItemContainerNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 13/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

class MenuItemContainerNode: SKShapeNode & SceneInteractable {
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
        label.font = configuration.font
        addChild(label)
        
        switch menuItem {
        case let _ as ChooserMenuItem:
            var node: SKNode
            let nodeSize = CGSize(width: configuration.menuWidth / 2, height: configuration.itemHeight)
            node = ChooserNode(size: nodeSize, font: configuration.font, values: ["Fighter", "Mage", "Thief"], selectedValueIdx: 0)
            addChild(node)
            node.position = CGPoint(x: configuration.menuWidth / 2, y: (frame.height - node.frame.height) / 2)
            node.zPosition = -1
        default: break
        }
        
        let labelX = (configuration.menuWidth / 2) / 2
        label.position = CGPoint(x: labelX, y: (self.frame.height - configuration.font.maxHeight) / 2)
        self.selected = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func up() {
        // ignore
    }
    
    func down() {
        // ignore
    }
    
    func left() {
        for node in self.children {
            if let interactableNode = node as? SceneInteractable {
                interactableNode.left()
            }
        }
    }
    
    func right() {
        for node in self.children {
            if let interactableNode = node as? SceneInteractable {
                interactableNode.right()
            }
        }
    }
}
