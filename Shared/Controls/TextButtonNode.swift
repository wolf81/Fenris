//
//  TextButtonNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 15/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import SpriteKit

open class TextButtonNode: ButtonNode {
    private var label: SKLabelNode

    public init(title: String, size: CGSize, onStateChanged: ((ButtonNode) -> ())? = nil) {
        self.label = SKLabelNode(text: title)

        super.init(size: size, onStateChanged: onStateChanged)
                
        self.name = "TextButtonNode \"\(title)\""
        
        self.label.position = CGPoint(x: 0, y: -(self.size.height / 4))
        self.label.verticalAlignmentMode = .baseline
        addChild(self.label)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
