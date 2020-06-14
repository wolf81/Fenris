//
//  GridNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 12/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import SpriteKit

public protocol GridNodeDelegate: class {
    func gridNodeNumberOfRows(_ gridNode: GridNode) -> Int
    func gridNode(_ gridNode: GridNode, numberOfItemsInRow row: Int) -> Int
    func gridNode(_ gridNode: GridNode, nodeForItemAtIndex index: Int) -> SKNode
    func gridNode(_ gridNode: GridNode, heightForRow row: Int) -> CGFloat
}

public class GridNode: ScrollNode {
    private var content: SKSpriteNode
    
    public weak var delegate: GridNodeDelegate? {
        didSet {
            reloadData()
        }
    }
    
    public init(color: SKColor, size: CGSize) {        
        self.content = SKSpriteNode(color: color, size: size)
        
        super.init(texture: nil, color: color, size: size)
    }
        
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    public func reloadData() {
        guard let delegate = self.delegate else { return }
        
        var height: CGFloat = 0
        
        let rowCount = delegate.gridNodeNumberOfRows(self)
        for i in (0 ..< rowCount) {
            height += delegate.gridNode(self, heightForRow: i)
        }
                        
        var n: Int = 0
        var y: CGFloat = self.size.height / 2
        for i in (0 ..< rowCount) {
            let rowItemCount = delegate.gridNode(self, numberOfItemsInRow: i)
            let itemWidth = floor(self.size.width / CGFloat(rowItemCount))
            let itemHeight = delegate.gridNode(self, heightForRow: i)

            var x: CGFloat = 0

            for _ in 0 ..< rowItemCount {
                let node = delegate.gridNode(self, nodeForItemAtIndex: n)

                self.content.addChild(node)
                
                switch node {
                case _ where node is SKSpriteNode:
                    node.position = CGPoint(x: x, y: y - itemHeight / 2)
                case let label as SKLabelNode:
                    node.position = CGPoint(x: x, y: y - itemHeight / 2 - label.frame.height / 2)
                default: fatalError()
                }
                
                x += itemWidth
                n += 1
            }
            
            y -= itemHeight
        }
        
        addContent(sprite: self.content)
        
        self.contentHeight = height
    }
}
