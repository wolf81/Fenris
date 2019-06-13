//
//  MenuContainerNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 13/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

class MenuContainerNode: SKShapeNode {
    var selectedItemIdx: Int = Int.min {
        didSet {
            print("idx: \(self.selectedItemIdx)")
        }
    }
    
    private var nodes: [MenuItemContainerNode]
    
    init(width: CGFloat, nodeHeight: CGFloat, nodes: [MenuItemContainerNode]) {
        self.nodes = nodes
        
        super.init()
        
        let height = nodeHeight * CGFloat(nodes.count)
        let pathRect = CGRect(x: 0, y: 0, width: width, height: height)
        self.path = CGPath(rect: pathRect, transform: nil)
        
        self.lineWidth = 1
        self.strokeColor = .clear
        
        var y = CGFloat(0)
        for node in nodes {
            addChild(node)
            node.position = CGPoint(x: 0, y: y)
            y += nodeHeight
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

extension MenuContainerNode: SceneInteractable {
    func up() {
        guard self.nodes.count > 0, selectedItemIdx != Int.min else {
            return selectFirstNode()
        }

        self.selectedItemIdx += 1
        self.selectedItemIdx = min(self.nodes.count - 1, self.selectedItemIdx)

        updateSelectedNode()
    }
    
    func down() {
        guard self.nodes.count > 0, selectedItemIdx != Int.min else {
            return selectFirstNode()
        }

        self.selectedItemIdx -= 1
        self.selectedItemIdx = max(0, self.selectedItemIdx)

        updateSelectedNode()
    }
    
    func left() {
        guard self.nodes.count > 0, selectedItemIdx != Int.min else {
            return selectFirstNode()
        }
        
        if let interactableNode = selectedNode() {
            interactableNode.left()
        }
    }
    
    func right() {
        guard self.nodes.count > 0, selectedItemIdx != Int.min else {
            return selectFirstNode()
        }
        
        if let interactableNode = selectedNode() {
            interactableNode.right()
        }
    }
    
    private func updateSelectedNode() {
        for (idx, node) in self.nodes.enumerated() {
            node.selected = idx == self.selectedItemIdx
        }
    }
    
    private func selectedNode() -> MenuItemContainerNode? {
        guard self.nodes.count > 0, selectedItemIdx != Int.min else {
            return nil
        }
        
        return self.nodes[self.selectedItemIdx]
    }
    
    private func selectFirstNode() {
        self.selectedItemIdx = 0
        updateSelectedNode()
    }
}
