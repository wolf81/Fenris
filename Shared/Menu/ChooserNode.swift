//
//  ChooserNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 13/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

class ChooserNode: SKShapeNode {
    init(size: CGSize) {
        super.init()
        
        self.strokeColor = SKColor.white
        self.lineWidth = 1

        var path = CGMutablePath()
        path.addRect(CGRect(origin: .zero, size: size))
        path.move(to: CGPoint(x: size.height, y: 0))
        path.addLine(to: CGPoint(x: size.height, y: size.height))
        path.move(to: CGPoint(x: size.width - size.height, y: 0))
        path.addLine(to: CGPoint(x: size.width - size.height, y: size.height))
        
        self.path = path
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
