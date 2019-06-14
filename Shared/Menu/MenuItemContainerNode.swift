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
    
    init(menuItem: MenuItem, configuration: MenuConfiguration) {
        self.menuItem = menuItem

        super.init()
        
        self.strokeColor = .clear
        self.isAntialiased = true

        let width = menuItem is ButtonMenuItem ? configuration.menuWidth / 2 : configuration.menuWidth
        
        let size = CGSize(width: width, height: configuration.itemHeight)
        self.path = CGPath(rect: CGRect(origin: .zero, size: size), transform: nil)
        
        switch menuItem {
        case let menuItem as ChooserMenuItem:
            var node: SKShapeNode
            let nodeSize = CGSize(width: configuration.menuWidth / 2, height: configuration.itemHeight)
            node = ChooserNode(size: nodeSize, font: configuration.font, menuItem: menuItem)
            addChild(node)
            node.position = CGPoint(x: configuration.menuWidth / 2, y: (self.frame.height - node.frame.height) / 2)
            node.zPosition = -1
        case let menuItem as ToggleMenuItem:
            var node: SKShapeNode
            let nodeSize = CGSize(width: configuration.menuWidth / 2, height: configuration.itemHeight)
            node = ToggleNode(size: nodeSize, font: configuration.font, menuItem: menuItem)
            addChild(node)
            node.position = CGPoint(x: configuration.menuWidth / 2, y: (self.frame.height - node.frame.height) / 2)
            node.zPosition = -1
        case let menuItem as NumberChooserMenuItem:
            var node: SKShapeNode
            let nodeSize = CGSize(width: configuration.menuWidth / 2, height: configuration.itemHeight)
            node = NumberChooserNode(size: nodeSize, font: configuration.font, menuItem: menuItem)
            addChild(node)
            node.position = CGPoint(x: configuration.menuWidth / 2, y: (self.frame.height - node.frame.height) / 2)
            node.zPosition = -1
        case let menuItem as LabelMenuItem:
            var node: SKShapeNode
            let nodeSize = CGSize(width: configuration.menuWidth / 2, height: configuration.itemHeight)
            node = DetailLabelNode(size: nodeSize, font: configuration.font, menuItem: menuItem)
            addChild(node)
            node.position = CGPoint(x: configuration.menuWidth / 2, y: (self.frame.height - node.frame.height) / 2)
            node.zPosition = -1
        default: break
        }
        
        let label = LabelNode(size: CGSize(width: configuration.menuWidth / 2, height: configuration.itemHeight), font: configuration.font, text: menuItem.title)
        addChild(label)
        label.position = CGPoint(x: 0, y: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func action() {
        for node in self.children {
            if let interactableNode = node as? SceneInteractable {
                interactableNode.action()
            }
        }
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
