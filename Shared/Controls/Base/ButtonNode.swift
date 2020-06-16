//
//  ButtonNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 13/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import SpriteKit

open class ButtonNode: SKSpriteNode & Selectable, MenuItemNode {
    private(set) var state: ControlState = .default
        
    private(set) var isSelecting: Bool = false {
        didSet {
            updateForSelectionState()
        }
    }
    
    public var isEnabled: Bool {
        set(value) {
            if value != self.isEnabled {
                self.state = value == true ? .default : .disabled
                updateForState()
            }
        }
        get {
            (self.state == .disabled) == false
        }
    }
    
    @objc dynamic public var highlightColor: SKColor = ButtonNode.appearance.highlightColor        
                
    private var textureInfo: [ControlState: SKTexture] = [:]
    
    public var onStateChanged: ((ButtonNode) -> ())?

    public var onSelected: ((ButtonNode) -> ())?
    
    public var onSelectStart: ((ButtonNode) -> ())?
    
    public var onSelectFinish: ((ButtonNode) -> ())?

    public var item: MenuItem = LabelItem(title: "bla")
            
    public var isHighlighted: Bool {
        set(value) {
            if value == true {
                self.state.insert(.highlighted)
            } else {
                self.state.remove(.highlighted)
            }
            updateForHighlightState()
        }
        get {
            return self.state.contains(.highlighted)
        }
    }
    
    public var isSelected: Bool {
        set(value) {
            if value == true {
                self.state.insert(.selected)
            } else {
                self.state.remove(.selected)
            }
            updateForSelectionState()
        }
        get {
            self.state.contains(.selected)
        }
    }
    
    public func setTexture(texture: SKTexture, for state: ControlState) {        
        self.textureInfo[state] = texture
        
        if self.state == state {
            updateForState()
        }
    }
    
    init(size: CGSize, item: ButtonItem, font: Font) {
        self.onStateChanged = { buttonNode in }
        
        let texture = SKTexture(imageNamed: "button")
        super.init(texture: texture, color: .yellow, size: size)                
    }
    
    public init(size: CGSize, onStateChanged: ((ButtonNode) -> ())? = nil) {
        self.onStateChanged = onStateChanged
        
        let bundle = Bundle(for: type(of: self))
        let image = bundle.image(forResource: "button")!
        let texture = SKTexture(image: image)
                
        let imageHighlighted = bundle.image(forResource: "button")!
        let highlightTexture = SKTexture(image: imageHighlighted)
    
        let imageSelected = bundle.image(forResource: "button-selected")!
        let selectedTexture = SKTexture(image: imageSelected)

        super.init(texture: texture, color: .clear, size: size)
        
        self.name = "ButtonNode"
        
        setTexture(texture: texture, for: .default)
        setTexture(texture: highlightTexture, for: .highlighted)
        setTexture(texture: selectedTexture, for: .selected)

        self.centerRect = CGRect(x: 0.4, y: 0.4, width: 0.2, height: 0.2)
    
        self.highlightColor = ButtonNode.appearance.highlightColor
                    
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
        
    func updateForHighlightState() {
        if self.state.contains(.disabled) { return }

        updateForState()
    }
    
    func updateForSelectionState() {
        if self.state.contains(.disabled) { return }
             
        updateForState()
                
        if self.isSelecting && self.isSelected == false {
            self.onSelectFinish?(self)
        } else if isSelected {
            self.onSelectStart?(self)
        }
    }
    
    func updateForState() {
        switch self.state {
        case _ where state.contains(.disabled):
            guard let texture = self.textureInfo[.disabled] else {
                self.texture = self.textureInfo[.default]
                return self.alpha = 0.5
            }
            self.texture = texture
            self.run(SKAction.colorize(with: .white, colorBlendFactor: 1.0, duration: 0))
        case _ where state.contains(.selected):
            self.texture = self.textureInfo[.selected]
            self.run(SKAction.colorize(with: self.highlightColor, colorBlendFactor: 1.0, duration: 0))
        case _ where state.contains(.highlighted):
            self.texture = self.textureInfo[.highlighted]
            self.run(SKAction.colorize(with: self.highlightColor, colorBlendFactor: 1.0, duration: 0))
        default:
            self.texture = self.textureInfo[.default]
            self.run(SKAction.colorize(with: .white, colorBlendFactor: 1.0, duration: 0))
            self.alpha = 1.0
        }
        
        self.onStateChanged?(self)
    }
}

extension ButtonNode: MouseDeviceInteractable {
    @objc public func onMouseEnter() {
        self.isHighlighted = true        
    }
    
    @objc public func onMouseExit() {
        self.isHighlighted = false
        
        if self.isSelected {
            self.isSelecting = false
            self.isSelected = false
        }
    }
    
    @objc public func onMouseDown() {
        self.isSelected = true
        self.isSelecting = true
    }
    
    @objc public func onMouseDrag(isTracking: Bool) {
        if self.isSelected != isTracking {
            self.isSelected = isTracking
        }        
    }
        
    @objc public func onMouseUp() {
        if self.isSelected {
            self.isSelected = false

            if self.isSelecting {
                self.onSelected?(self)
                self.isSelecting = false
            }
        }
    }
}