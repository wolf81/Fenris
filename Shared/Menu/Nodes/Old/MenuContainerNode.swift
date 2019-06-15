//
//  MenuContainerNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 13/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

/*
class MenuContainerNode: SKShapeNode {
    private var focusNode: SKShapeNode!
    
    var focusedItemIdx: Int = Int.min {
        didSet {
            self.focusNode.isHidden = (self.focusedItemIdx == Int.min)
            updateFocusedNode()
        }
    }
    
    private var nodes: [MenuItemContainerNode]
    
    init(width: CGFloat, nodeHeight: CGFloat, nodes: [MenuItemContainerNode]) {
        self.nodes = nodes.reversed()
        
        super.init()
                
        let height = nodeHeight * CGFloat(nodes.count)
        let pathRect = CGRect(x: 0, y: 0, width: width, height: height)
        self.path = CGPath(rect: pathRect, transform: nil)
        
        self.lineWidth = 0
        self.strokeColor = .clear
        
        var y = CGFloat(0)
        for node in self.nodes {
            addChild(node)
            node.position = CGPoint(x: 0, y: y)
            y += nodeHeight
        }
        
        let focusFrame = nodes.first?.frame ?? .zero
        self.focusNode = SKShapeNode(path: CGPath(rect: focusFrame, transform: nil))
        
        self.focusedItemIdx = Int.min
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

extension MenuContainerNode: SceneInteractable {
    func action() {
        guard self.focusedItemIdx != Int.min else {
            return focusFirstNode()
        }

        if let interactableNode = focusedNode() {
            interactableNode.action()
        }
    }
    
    func down() {
        guard self.focusedItemIdx != Int.min else {
            return focusFirstNode()
        }

        self.focusedItemIdx += 1
        self.focusedItemIdx = min(self.nodes.count - 1, self.focusedItemIdx)
    }
    
    func up() {
        guard self.focusedItemIdx != Int.min else {
            return focusFirstNode()
        }

        self.focusedItemIdx -= 1
        self.focusedItemIdx = max(0, self.focusedItemIdx)
    }
    
    func left() {
        guard self.focusedItemIdx != Int.min else {
            return focusFirstNode()
        }

        if let interactableNode = focusedNode() {
            interactableNode.left()
        }
    }
    
    func right() {
        guard self.focusedItemIdx != Int.min else {
            return focusFirstNode()
        }
        
        if let interactableNode = focusedNode() {
            interactableNode.right()
        }
    }
    
    private func updateFocusedNode() {
        self.focusNode?.removeFromParent()
        
        for (idx, node) in self.nodes.reversed().enumerated() {
            guard idx == focusedItemIdx else { continue }
            
            self.focusNode = SKShapeNode(path: CGPath(rect: node.frame, transform: nil))
            self.focusNode.strokeColor = .yellow
            self.focusNode.lineWidth = 1
            addChild(self.focusNode)
        }
    }
    
    private func focusedNode() -> MenuItemContainerNode? {
        guard self.nodes.count > 0, focusedItemIdx != Int.min else {
            return nil
        }
        
        return self.nodes.reversed()[self.focusedItemIdx]
    }
    
    private func focusFirstNode() {
        guard self.nodes.count > 0 else {
            return
        }
        
        self.focusedItemIdx = 0
    }
}
*/
