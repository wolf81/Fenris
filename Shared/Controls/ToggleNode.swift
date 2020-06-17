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
    
    public init() {
        self.switchSprite = SKSpriteNode(texture: nil, color: .clear, size: CGSize(width: 32, height: 32))
        self.switchSprite.zPosition = 1_000
        
        super.init(size: CGSize(width: 64, height: 32))
        
        self.name = "ToggleNode"
        
        let bundle = Bundle.init(for: type(of: self))
        
        let defaultTexture = SKTexture.texture(named: "toggle", fromBundle: bundle)
        setTexture(texture: defaultTexture, for: .default)
        setTexture(texture: defaultTexture, for: .highlighted)

        let selectedTexture = SKTexture.texture(named: "toggle-selected", fromBundle: bundle)
        setTexture(texture: selectedTexture, for: .selected)

        updateForState()
        
        addChild(self.switchSprite)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Private
    
    override func updateForState() {
        super.updateForState()
        
        var x: CGFloat = 0

        if self.isOn {
            x = -(self.size.width / 2) + self.switchSprite.size.width / 2 + 6
        } else {
            x = (self.size.width / 2) - self.size.height / 2 - 6
        }
        
        let bundle = Bundle.init(for: type(of: self))
        let texture = SKTexture.texture(named: "toggle-switch", fromBundle: bundle)

        self.switchSprite.run(SKAction.setTexture(texture))
        self.switchSprite.position = CGPoint(x: x, y: 0)

        self.centerRect = CGRect(x: 0.49, y: 0.49, width: 0.02, height: 0.02)
    }
    
    public override func onMouseUp() {        
        self.isSelected = !self.isSelected
    }
    
    public override func onMouseDown() {
    }
    
    public override func onMouseDrag(isTracking: Bool) {

    }
    
    public override func onMouseExit() {
        self.isHighlighted = false
    }
}

