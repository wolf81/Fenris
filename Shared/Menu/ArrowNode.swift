//
//  ArrowNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 13/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

class ArrowNode: SKShapeNode {
    enum Direction {
        case left
        case right
    }
    
    init(size: CGSize, direction: Direction) {
        super.init()
                
        self.strokeColor = .white
        self.fillColor = .white
        self.lineWidth = 1
        
        let path = CGMutablePath()
        
        switch direction {
        case .left:
            path.move(to: CGPoint(x: size.width, y: 0))
            path.addLine(to: CGPoint(x: 0, y: size.height / 2))
            path.addLine(to: CGPoint(x: size.width, y: size.height))
        case .right:
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: size.width, y: size.height / 2))
            path.addLine(to: CGPoint(x: 0, y: size.height))
        }
        
        path.closeSubpath()
        
        self.path = path
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
