//
//  ImageButtonNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 15/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import SpriteKit

open class ImageButtonNode: ButtonNode {
    let sprite: SKSpriteNode
    
    public init(texture: SKTexture, size: CGSize, onSelected: ((ButtonNode) -> ())? = nil) {
        self.sprite = SKSpriteNode(texture: texture, color: .white, size: size)
        
        super.init(size: size, onSelected: onSelected)
        
        addChild(self.sprite)
        
        self.sprite.position = CGPoint.zero
        self.sprite.zPosition = 1_000
        
        self.name = "ImageButtonNode"
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
