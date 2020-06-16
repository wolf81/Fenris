//
//  ImageButtonNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 15/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import SpriteKit

open class ImageButtonNode: ButtonNode {
    public init(texture: SKTexture, size: CGSize, onStateChanged: ((ButtonNode) -> ())? = nil) {
        super.init(size: size, onStateChanged: onStateChanged)
        
        self.name = "ImageButtonNode"
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
