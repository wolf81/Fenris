//
//  MenuRowNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 15/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

class MenuRowNode: SKShapeNode {
    typealias NodeLayout = (width: CGFloat, spacing: CGFloat)
    
    private(set) var itemNodes: [MenuItemNode] = []
    
    init(size: CGSize, items: [MenuItem], font: Font, footerMinimumHorizontalSpacing: CGFloat) {
        super.init()
        
        self.path = CGPath(rect: CGRect(origin: .zero, size: size), transform: nil)
        self.lineWidth = 0

        let nodeLayout = items.count > 1 ? getItemNodeWidth(width: size.width, minimumHorizontalSpacing: 5, itemCount: items.count) : NodeLayout(width: size.width, spacing: footerMinimumHorizontalSpacing)
        
        for (idx, item) in items.enumerated() {
            let nodeSize = CGSize(width: nodeLayout.width, height: size.height)
            let node = item.getNode(size: nodeSize, font: font)
            addChild(node)            
            
            node.position = CGPoint(x: CGFloat(idx) * (nodeSize.width + nodeLayout.spacing), y: 0)
            self.itemNodes.append(node)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    // MARK: Private
    
    func getItemNodeWidth(width: CGFloat, minimumHorizontalSpacing: CGFloat, itemCount: Int) -> NodeLayout {
        let maximumItemWidth = width - CGFloat(itemCount - 1) * minimumHorizontalSpacing
        var itemWidth = floor(maximumItemWidth / CGFloat(itemCount))
        let spacerCount = itemCount - 1
        
        while (true) {
            let remainder = maximumItemWidth - itemWidth * CGFloat(itemCount)
            let spacerRemainder = remainder.remainder(dividingBy: CGFloat(spacerCount))
            if remainder == 0 || spacerRemainder == 0 {
                break
            }
            
            itemWidth -= 1
        }
           
        let totalItemWidth = itemWidth * CGFloat(itemCount)
        let totalSpacerWidth = width - totalItemWidth
        let spacerWidth = totalSpacerWidth / (CGFloat(itemCount - 1))
        
        return NodeLayout(width: itemWidth, spacing: spacerWidth)
    }
}
