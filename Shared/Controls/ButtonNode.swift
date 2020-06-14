//
//  ButtonNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 13/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import SpriteKit

public struct ControlState: OptionSet, Hashable {
    public let rawValue: UInt8
    
    static let `default` = ControlState(rawValue: 1 << 0)
    static let highlighted = ControlState(rawValue: 1 << 1)
    static let selected = ControlState(rawValue: 1 << 2)
    static let disabled = ControlState(rawValue: 1 << 3)
    
    public init(rawValue: UInt8) {
        self.rawValue = rawValue
    }
}

open class ButtonNode: SKSpriteNode & Selectable, MenuItemNode {
    private var state: ControlState = .default
    
    private struct SpriteKey {
        static let selected = "selected"
    }
    
    public var isEnabled: Bool = true {
        didSet {
            if self.isEnabled {
                self.state.remove(.disabled)
            } else {
                self.state.insert(.disabled)
            }
            
            updateForState()
        }
    }
            
    private var label: SKLabelNode
    
    private var textureInfo: [ControlState: SKTexture] = [:]
    
    public var onSelected: ((ButtonNode) -> ())?
    
    public var onHighlighted: ((ButtonNode) -> ())?
        
    public var item: MenuItem = LabelItem(title: "bla")
            
    public var isHighlighted: Bool = false {
        didSet {
            if self.isHighlighted {
                self.state.insert(.highlighted)
            } else {
                self.state.remove(.highlighted)
            }

            updateForHighlightState()
        }
    }
    
    public var isSelected: Bool = false {
        didSet {
            if self.isSelected {
                self.state.insert(.selected)
            } else {
                self.state.remove(.selected)
            }

            updateForSelectionState()
        }
    }
    
    public func setTexture(texture: SKTexture, for state: ControlState) {        
        self.textureInfo[state] = texture
    }
    
    init(size: CGSize, item: ButtonItem, font: Font) {
        self.onSelected = { buttonNode in }
        self.label = SKLabelNode(text: "Hi")
        
        let texture = SKTexture(imageNamed: "button")
        super.init(texture: texture, color: .yellow, size: size)
                
        self.label.position = CGPoint(x: size.width / 2, y: size.height / 2)
    }
    
    public init(title: String, size: CGSize, onSelected: ((ButtonNode) -> ())? = nil) {
        self.onSelected = onSelected
        self.label = SKLabelNode(text: title)
        
        let bundle = Bundle(for: type(of: self))
        let image = bundle.image(forResource: "button")!
        let texture = SKTexture(image: image)
                
        let imageHighlighted = bundle.image(forResource: "button-highlighted")!
        let highlightTexture = SKTexture(image: imageHighlighted)

        let imageSelected = bundle.image(forResource: "button-selected")!
        let selectedTexture = SKTexture(image: imageSelected)

        super.init(texture: texture, color: .clear, size: size)
        
        setTexture(texture: texture, for: .default)
        setTexture(texture: highlightTexture, for: .highlighted)
        setTexture(texture: selectedTexture, for: .selected)

        self.centerRect = CGRect(x: 0.4, y: 0.4, width: 0.2, height: 0.2)
        self.label.position = CGPoint.zero
        self.label.verticalAlignmentMode = .center
        addChild(self.label)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Private
        
    func updateForHighlightState() {
        if self.state.contains(.disabled) { return }

        updateForState()
    }
    
    func updateForSelectionState() {
        if self.state.contains(.disabled) { return }

        updateForState()
    }
    
    func updateForState() {
        switch self.state {
        case _ where state.contains(.selected):
            guard self.childNode(withName: SpriteKey.selected) == nil else { return }
                        
            let texture = self.textureInfo[.selected]
            let sprite = SKSpriteNode(texture: texture, color: color, size: size)
            sprite.centerRect = self.centerRect
            sprite.name = SpriteKey.selected
            sprite.alpha = 0.0
            addChild(sprite)

            let fadeInOut = SKAction.sequence([
                SKAction.fadeIn(withDuration: 0.1),
                SKAction.fadeOut(withDuration: 0.1),
                SKAction.run { [unowned self] in
                    sprite.removeFromParent()
                    self.isSelected = false
                    self.onSelected?(self)
                }
            ])
            sprite.run(fadeInOut)
        case _ where state.contains(.highlighted):
            self.onHighlighted?(self)

            self.texture = self.textureInfo[.highlighted]
        case _ where state.contains(.disabled):
            guard let texture = self.textureInfo[.disabled] else {
                return self.alpha = 0.5
            }
            self.texture = texture
        default:
            self.texture = self.textureInfo[.default]
            self.alpha = 1.0
        }
    }
}


