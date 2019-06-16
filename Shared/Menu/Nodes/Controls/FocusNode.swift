//
//  FocusNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 17/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

class FocusNode: SKShapeNode {
    init(strokeColor: SKColor) {
        super.init()
        
        self.lineWidth = 1
        self.strokeColor = strokeColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
