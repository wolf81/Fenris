//
//  ToggleNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 15/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import SpriteKit

open class ToggleNode: ButtonNode {
    private var switchSprite: SKSpriteNode
    
    public var isOn: Bool = false {
        didSet { updateForState() }
    }
    
    public override var isSelected: Bool {
        set(value) {
            self.isOn = !self.isOn
            super.isSelected = value
        }
        get {
            super.isSelected
        }
    }
    
    public init(size: CGSize, item: ToggleItem, font: Font) {
        self.switchSprite = SKSpriteNode(texture: nil)
        
        super.init(size: size, item: ButtonItem(title: "hi"), font: font)
    }
    
    public init(size: CGSize) {
        self.switchSprite = SKSpriteNode(texture: nil, color: .clear, size: CGSize(width: 32, height: 32))
        
        super.init(size: CGSize(width: 64, height: 32))
        
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
        
        updateForState()
        
        addChild(self.switchSprite)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Private
    
    override func updateForState() {
        super.updateForState()

        let bundle = Bundle.init(for: type(of: self))
        var image: NSImage
        
        var x: CGFloat = 0

        if self.isOn {
            image = bundle.image(forResource: "toggle-switch-highlighted")!
            x = -(self.size.width / 2) + self.switchSprite.size.width / 2 + 6
        } else {
            image = bundle.image(forResource: "toggle-switch")!
            x = (self.size.width / 2) - self.size.height / 2 - 6
        }
        
        let texture = SKTexture(image: image)
        self.switchSprite.run(SKAction.setTexture(texture))
        self.switchSprite.position = CGPoint(x: x, y: 0)
    }
}
