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
    private var borderSprite: SKSpriteNode
    
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
        
    public init() {
        let bundle = Bundle.init(for: type(of: self))

        let switchTexture = SKTexture.texture(named: "toggle-switch", fromBundle: bundle)
        self.switchSprite = SKSpriteNode(texture: switchTexture, color: .clear, size: CGSize(width: 32, height: 32))
        self.switchSprite.zPosition = 1_000
        
        let borderTexture = SKTexture.texture(named: "toggle", fromBundle: bundle)
        self.borderSprite = SKSpriteNode(texture: borderTexture, color: .clear, size: CGSize(width: 64, height: 32))
        self.borderSprite.zPosition = 500

        super.init(size: CGSize(width: 64, height: 32))
        
        self.name = "ToggleNode"
                
        let defaultTexture = SKTexture.texture(named: "toggle", fromBundle: bundle)
        setTexture(texture: defaultTexture, for: .default)
        setTexture(texture: defaultTexture, for: .highlighted)

        let selectedTexture = SKTexture.texture(named: "toggle-selected", fromBundle: bundle)
        setTexture(texture: selectedTexture, for: .selected)

        updateForState()
        
        addChild(self.borderSprite)
        addChild(self.switchSprite)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Private
    
    override func updateForState() {
        super.updateForState()
        
        if self.state.contains(.highlighted) {
            self.borderSprite.run(SKAction.colorize(with: self.highlightColor, colorBlendFactor: 1.0, duration: 0))
        } else {
            self.borderSprite.run(SKAction.colorize(with: .white, colorBlendFactor: 1.0, duration: 0))
        }

        var x: CGFloat = ((self.size.width - self.switchSprite.size.width) / 2)
        let xOffset: CGFloat = 5
        
        if self.isOn {
            x = -(x) + xOffset
        } else {
            x = x - xOffset
        }
        
        self.switchSprite.run(SKAction.moveTo(x: x, duration: 0.1))
        
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

