//
//  ToggleNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 15/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import SpriteKit

open class ToggleNode: ButtonNode {
    public init(size: CGSize, item: ToggleItem, font: Font) {
        super.init(size: size, item: ButtonItem(title: "hi"), font: font)
    }
    
    public init(size: CGSize) {
        super.init(size: size)
        
        let bundle = Bundle.init(for: type(of: self))
        
        let defaultImage = bundle.image(forResource: "toggle")!
        let defaultTexture = SKTexture(image: defaultImage)
        setTexture(texture: defaultTexture, for: .default)

        let highlightImage = bundle.image(forResource: "toggle-highlighted")!
        let highlightTexture = SKTexture(image: highlightImage)
        setTexture(texture: highlightTexture, for: .highlighted)

        let selectedImage = bundle.image(forResource: "toggle-selected")!
        let selectedTexture = SKTexture(image: selectedImage)
        setTexture(texture: selectedTexture, for: .selected)

        self.centerRect = CGRect(x: 0.45, y: 0.45, width: 0.1, height: 0.1)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
