//
//  SignNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 14/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

class SignNode: SKShapeNode {
    enum Sign {
        case plus
        case minus
    }
    
    init(size: CGSize, sign: Sign) {
        super.init()
        
        self.strokeColor = .white
        self.fillColor = .white
        self.lineWidth = 1
        self.isAntialiased = true
        
        let path = CGMutablePath()
        
        let lineWidth = size.width / 3
        
        switch sign {
        case .plus:
            let y = (size.height - lineWidth) / 2
            path.addRect(CGRect(x: 0, y: y, width: size.width, height: lineWidth))
            
            let x = (size.width - lineWidth) / 2
            path.addRect(CGRect(x: x, y: 0, width: lineWidth, height: size.height))
        case .minus:
            let y = (size.height - lineWidth) / 2
            path.addRect(CGRect(x: 0, y: y, width: size.width, height: lineWidth))
        }
        
        path.closeSubpath()
        
        self.path = path
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
