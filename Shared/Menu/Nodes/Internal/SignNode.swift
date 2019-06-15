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
            path.move(to: CGPoint(x: (size.width - lineWidth) / 2, y: 0))
            path.addLine(to: CGPoint(x: (size.width - lineWidth) / 2 + lineWidth, y: 0))
            path.addLine(to: CGPoint(x: (size.width - lineWidth) / 2 + lineWidth, y: (size.height - lineWidth) / 2))
            path.addLine(to: CGPoint(x: size.width, y: (size.height - lineWidth) / 2))
            path.addLine(to: CGPoint(x: size.width, y: (size.height - lineWidth) / 2 + lineWidth))
            path.addLine(to: CGPoint(x: (size.width - lineWidth) / 2 + lineWidth, y: (size.height - lineWidth) / 2 + lineWidth))
            path.addLine(to: CGPoint(x: (size.width - lineWidth) / 2 + lineWidth, y: size.height))
            path.addLine(to: CGPoint(x: (size.width - lineWidth) / 2, y: size.height))
            path.addLine(to: CGPoint(x: (size.width - lineWidth) / 2, y: (size.height - lineWidth) / 2 + lineWidth))
            path.addLine(to: CGPoint(x: 0, y: (size.height - lineWidth) / 2 + lineWidth))
            path.addLine(to: CGPoint(x: 0, y: (size.height - lineWidth) / 2))
            path.addLine(to: CGPoint(x: (size.width - lineWidth) / 2, y: (size.height - lineWidth) / 2))
            path.closeSubpath()

//            path.addLine(to: CGPoint(x: <#T##CGFloat#>, y: <#T##CGFloat#>))
//            path.addLine(to: CGPoint(x: <#T##CGFloat#>, y: <#T##CGFloat#>))
//            path.addLine(to: CGPoint(x: <#T##CGFloat#>, y: <#T##CGFloat#>))
//            path.addLine(to: CGPoint(x: <#T##CGFloat#>, y: <#T##CGFloat#>))

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
