//
//  SignNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 14/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

class SignButtonNode: SKShapeNode {
    init(size: CGSize, sign: SignNode.Sign) {
        super.init()
        
        self.path = CGPath(rect: CGRect(origin: .zero, size: size), transform: nil)
        
        self.lineWidth = 0
        self.strokeColor = .clear
        self.fillColor = SKColor.yellow.withAlphaComponent(0.2)
        
        let signSize = CGSize(width: size.width / 2, height: size.height / 2)
        
        let signNode = SignNode(size: signSize, sign: sign)
        signNode.zPosition = 100
        addChild(signNode)
        
        signNode.position = CGPoint(x: (size.width - signSize.width) / 2, y: (size.height - signSize.height) / 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
