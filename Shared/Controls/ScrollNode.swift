//
//  ScrollNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 14/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import SpriteKit

public class ScrollNode: SKSpriteNode {
    enum ScrollDirection {
        case up
        case down
        case none
    }
        
    private let cropNode: SKCropNode
    private let content: SKSpriteNode
    private let scrollbar: ScrollbarNode
    private let highlightNode: HighlightNode
    
    public var contentHeight: CGFloat = 0 {
        didSet {
            guard let sprite = self.cropNode.children.first as? SKSpriteNode else { return }
            
            sprite.run(SKAction.resize(toHeight: self.contentHeight, duration: 0))

            self.contentY = self.contentHeight - self.size.height / 2
            
            self.setScrollbarVisible(self.contentHeight > self.size.height)
        }
    }
    
    public private(set) var contentY: CGFloat = 0 {
        didSet {
            didScroll()
            updateLayout()
        }
    }
    
    private var contentMaxY: CGFloat { max(self.size.height / 2, self.contentHeight / 2) }
    private var contentMinY: CGFloat { self.size.height / 2 }

    private var scrollTimer: Timer?

    private var scrollDirection: ScrollDirection = .none {
        didSet {
            switch self.scrollDirection {
            case .none:
                self.scrollTimer?.invalidate()
                self.scrollTimer = nil
            default:
                guard self.scrollTimer == nil else { return }
                self.scrollTimer = Timer.scheduledTimer(timeInterval: 0.005, target: self, selector: #selector(ScrollNode.performAutoscroll), userInfo: nil, repeats: true)
            }
        }
    }    

    public func addContent(sprite: SKSpriteNode) {
        self.contentHeight = sprite.size.height
        
        self.cropNode.addChild(sprite)
        
        self.contentY = max(self.contentY, self.size.height / 2)
        
        updateLayout()
    }
    
    public override init(texture: SKTexture?, color: SKColor, size: CGSize) {
        let buttonSize = CGSize(width: 32, height: 32)

        self.cropNode = SKCropNode()
        self.contentHeight = size.height
        self.highlightNode = HighlightNode(size: size)
                
        let contentSize = CGSize(width: size.width, height: size.height)
        self.content = SKSpriteNode(texture: nil, color: color, size: contentSize)
        self.scrollbar = ScrollbarNode(texture: nil, color: SKColor.black.withAlphaComponent(0.5), size: CGSize(width: buttonSize.width, height: size.height))
        
        super.init(texture: texture, color: color, size: size)
        
        self.name = "ScrollNode"
        
        self.anchorPoint = .zero
        
        self.content.anchorPoint = .zero
        self.content.position = .zero
        addChild(self.content)
        
        self.scrollbar.anchorPoint = CGPoint.zero
        self.scrollbar.position = CGPoint(x: size.width - self.scrollbar.size.width, y: 0)
        self.scrollbar.zPosition = 1000
        self.scrollbar.upButton.onSelectStart = { [unowned self] _ in self.scrollDirection = .up }
        self.scrollbar.upButton.onSelectFinish = { [unowned self] _ in self.scrollDirection = .none }
        self.scrollbar.downButton.onSelectStart = { [unowned self] _ in self.scrollDirection = .down }
        self.scrollbar.downButton.onSelectFinish = { [unowned self] _ in self.scrollDirection = .none }
        addChild(self.scrollbar)
                
        self.cropNode.maskNode = self.content
        addChild(self.cropNode)

        self.highlightNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        self.highlightNode.highlightChanged = { [unowned self] in self.toggleScrollbarVisibility(isHighlighted: $0) }
        addChild(self.highlightNode)

        setScrollbarVisible(false)
    }
        
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    open func didScroll() {
        // can be implemented by subclasses
    }
    
    private func scrollUp(buttonNode: ButtonNode) {
        if self.scrollDirection == .down { return }
        
        self.scrollDirection = buttonNode.isSelected ? .up : .none
    }
    
    private func scrollDown(buttonNode: ButtonNode) {
        if self.scrollDirection == .up { return }

        self.scrollDirection = buttonNode.isSelected ? .down : .none
    }
        
    private func setScrollbarVisible(_ isVisible: Bool) {
        self.scrollbar.alpha = isVisible ? 1.0 : 0.0            
    }
    
    @objc private func performAutoscroll() {
        DispatchQueue.main.async { [unowned self] in
            switch self.scrollDirection {
            case .down:
                let y = min(self.contentY + 1, self.contentMaxY)
                if self.scrollbar.downButton.isEnabled == false { self.scrollDirection = .none }
                self.contentY = y
            case .up:
                let y = max(self.contentY - 1, self.contentMinY)
                if self.scrollbar.upButton.isEnabled == false { self.scrollDirection = .none }
                self.contentY = y
            default: break
            }
            self.updateLayout()
        }
    }
    
    private func updateLayout() {
        guard let childNode = self.cropNode.children.first as? SKSpriteNode else { return }
        
        self.scrollbar.upButton.isEnabled = self.contentY != self.size.height / 2
        self.scrollbar.downButton.isEnabled = self.contentY != max(self.size.height / 2, self.contentHeight / 2)
        self.scrollbar.scroller.isEnabled = self.scrollbar.upButton.isEnabled || self.scrollbar.downButton.isEnabled

        let yRange = abs(self.contentMaxY - self.contentMinY)
        self.scrollbar.scrollerY = (self.contentY - self.contentMinY) / yRange

        childNode.position = CGPoint(x: childNode.size.width / 2, y: self.contentY)
    }
    
    private func toggleScrollbarVisibility(isHighlighted: Bool) {
        guard self.contentHeight > self.size.height else { return }

        if isHighlighted {
            self.scrollbar.run(SKAction.fadeIn(withDuration: 0.1))
        } else {
            self.scrollbar.run(SKAction.fadeOut(withDuration: 0.1))
            clearHighlightingOnChildNodes()
        }
    }
    
    private class HighlightNode: ControlNode & Highlightable & DeviceInteractable {
        var highlightChanged: ((Bool) -> Void)? = nil

        override init(size: CGSize) {
            super.init(size: size)
            
            self.isEnabled = false
            
            self.name = "HighlightNode"
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError()
        }
        
        var isHighlighted: Bool = false {
            didSet {
                self.highlightChanged?(self.isHighlighted)
            }
        }
        
        func onEnter() {
            if self.isHighlighted != true {
                self.isHighlighted = true
            }
        }
        
        func onExit() {
            if self.isHighlighted != false {
                self.isHighlighted = false
            }
        }
        
        func onDown() {
            
        }
        
        func onUp() {
            
        }
        
        func onDrag(isTracking: Bool) {
        
        }
    }
}
