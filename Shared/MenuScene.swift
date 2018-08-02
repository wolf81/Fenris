//
//  MenuScene.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 01/08/2018.
//  Copyright © 2018 Wolftrail. All rights reserved.
//

import SpriteKit

protocol MenuNode where Self: SKShapeNode {
    var titleLabelMaxX: CGFloat { get }
    var spacing: CGFloat { get }
}

public class MenuScene: SKScene {
    typealias MenuControl = SKShapeNode & MenuNode
    
    private var options: [MenuOption] = []
    
    private var controls: [MenuControl] {
        var nodes: [SKNode] = []
        for node in self.children where node is MenuControl {
            nodes.append(node)
        }
        return nodes as! [MenuScene.MenuControl]
    }
    
    private var alignControls = false

    public init(size: CGSize, options: [MenuOption]) {
        self.options = options
        
        super.init(size: size)
        
        addChildNodesForMenuOptions()
        layoutChildNodesForMenuOptions()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    private func addChildNodesForMenuOptions() {
        for option in self.options {
            guard let node = MenuNodeFactory.menuNodeFor(option: option) else {
                continue
            }
            
            addChild(node)
        }
    }
    
    private func layoutChildNodesForMenuOptions() {
        let x: CGFloat = self.size.width / 2
        let y: CGFloat = self.size.height / 2
        
        let itemCountForHeight = fmaxf(Float(options.count - 1), 0)
        let totalHeight = CGFloat(itemCountForHeight * 100)
        let originY = y + (totalHeight / 2)
        
        for (idx, option) in options.enumerated().reversed() {
            let y = CGFloat(originY) - CGFloat(idx * 100)

            if let label = controlForMenuOption(option) {
                label.position = CGPoint(x: x - label.titleLabelMaxX, y: y)
            }
        }
    }
    
    fileprivate func controlForMenuOption(_ option: MenuOption) -> MenuControl? {
        let idx = indexOfMenuOption(option)
        return idx != NSNotFound ? controls[idx] : nil
    }
    
    fileprivate func indexOfMenuOption(_ option: MenuOption) -> Int {
        var idx = NSNotFound
        
        for (testIdx, testOption) in options.enumerated() {
            if testOption === option {
                idx = testIdx
            }
        }
        
        return idx
    }
}
