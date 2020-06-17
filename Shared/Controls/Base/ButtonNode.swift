//
//  ButtonNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 13/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import SpriteKit

open class ButtonNode: ControlNode & Selectable {
    @objc dynamic public var highlightColor: SKColor = ButtonNode.appearance.highlightColor
                
    private var textureInfo: [ControlState: SKTexture] = [:]
    
    public var onSelected: ((ButtonNode) -> ())?
    
    public var onSelectStart: ((ButtonNode) -> ())?
    
    public var onSelectFinish: ((ButtonNode) -> ())?
            
    public func setTexture(texture: SKTexture?, for state: ControlState) {
        self.textureInfo[state] = texture
        
        if self.state == state {
            updateForState()
        }
    }
        
    public init(size: CGSize, onSelected: ((ButtonNode) -> ())? = nil) {
        self.onSelected = onSelected
        
        let bundle = Bundle(for: type(of: self))
        
        super.init(size: size)
        
        self.name = "ButtonNode"
        
        let defaultTexture = SKTexture.texture(named: "button", fromBundle: bundle)
        setTexture(texture: defaultTexture, for: .default)
        setTexture(texture: defaultTexture, for: .highlighted)
        
        let selectedTexture = SKTexture.texture(named: "button-selected", fromBundle: bundle)
        setTexture(texture: selectedTexture, for: .selected)
                        
        ButtonNode.appearance.addObserver(self, forKeyPath: #keyPath(highlightColor), options: [.new], context: nil)
    }
    
    deinit {
        ButtonNode.appearance.removeObserver(self, forKeyPath: #keyPath(highlightColor))
    }

    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard object is Appearance else { return }

        switch keyPath {
        case #keyPath(Appearance.highlightColor): self.highlightColor = ButtonNode.appearance.highlightColor
        default: break
        }
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Private
                
    override func updateForState() {
        switch self.state {
        case _ where state.contains(.disabled):
            guard let texture = self.textureInfo[.disabled] else {
                self.texture = self.textureInfo[.default]
                self.run(SKAction.sequence([
                    SKAction.colorize(with: .white, colorBlendFactor: 1.0, duration: 0.1),
                    SKAction.fadeAlpha(to: 0.5, duration: 0.1)
                ]))
                return
            }
            self.texture = texture
        case _ where state.contains(.selected):
            self.texture = self.textureInfo[.selected]
            self.run(SKAction.colorize(with: self.highlightColor, colorBlendFactor: 1.0, duration: 0))
        case _ where state.contains(.highlighted):
            self.texture = self.textureInfo[.highlighted]
            self.run(SKAction.colorize(with: self.highlightColor, colorBlendFactor: 1.0, duration: 0))
        default:
            self.texture = self.textureInfo[.default]
            self.run(SKAction.colorize(with: .white, colorBlendFactor: 1.0, duration: 0))
            self.run(SKAction.fadeIn(withDuration: 0.1))
        }
        
        self.centerRect = CGRect(x: 0.1, y: 0.1, width: 0.8, height: 0.8)
    }
}

extension ButtonNode: DeviceInteractable {
    @objc public func onEnter() {
        guard self.isEnabled else { return }

        self.isHighlighted = true
    }
    
    @objc public func onExit() {
        guard self.isEnabled else { return }

        self.isHighlighted = false
        
        if self.isSelected {
            self.isSelected = false
            self.onSelectFinish?(self)
        }
    }
    
    @objc public func onDown() {
        guard self.isEnabled else { return }

        self.isSelected = true
        self.onSelectStart?(self)
    }
    
    @objc public func onDrag(isTracking: Bool) {
        guard self.isEnabled else { return }

        if self.isSelected != isTracking {
            self.isSelected = isTracking
            
            if isTracking {
                self.onSelectStart?(self)
            } else {
                self.onSelectFinish?(self)
            }
        }        
    }
        
    @objc public func onUp() {
        guard self.isEnabled else { return }

        if self.isSelected {
            self.isSelected = false

            self.onSelected?(self)
            self.onSelectFinish?(self)
        }
    }
}
