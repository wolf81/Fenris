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
    private let scrollbar: SKSpriteNode
    private let upButton: ButtonNode
    private let downButton: ButtonNode
    
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
        
//        sprite.position = CGPoint(x: sprite.size.width / 2, y: self.contentY)
        self.cropNode.addChild(sprite)
        
        let y = max(self.contentY, self.size.height / 2)
        self.contentY = y
        
        updateLayout()
    }
    
    public override init(texture: SKTexture?, color: NSColor, size: CGSize) {
        let buttonSize = CGSize(width: 32, height: 32)

        self.cropNode = SKCropNode()
        self.contentHeight = size.height
        
        let contentSize = CGSize(width: size.width, height: size.height)
        self.content = SKSpriteNode(texture: nil, color: .lightGray, size: contentSize)
        self.scrollbar = SKSpriteNode(color: SKColor.black.withAlphaComponent(0.5), size: CGSize(width: buttonSize.width, height: size.height))
        self.upButton = ButtonNode(title: "u", size: buttonSize)
        self.downButton = ButtonNode(title: "d", size: buttonSize)
        
        super.init(texture: texture, color: color, size: size)
        
        self.anchorPoint = .zero
        
        self.content.anchorPoint = .zero
        self.content.position = .zero
        addChild(self.content)
        
        self.scrollbar.anchorPoint = CGPoint.zero
        self.scrollbar.position = CGPoint(x: size.width - self.scrollbar.size.width, y: 0)
        self.scrollbar.zPosition = 1000
        addChild(self.scrollbar)
        
        self.upButton.onStateChanged = scrollUp(buttonNode:)
        self.upButton.position = CGPoint(x: buttonSize.width / 2, y: size.height - buttonSize.height / 2)
        self.scrollbar.addChild(self.upButton)
        
        self.downButton.position = CGPoint(x: buttonSize.width / 2, y: buttonSize.height / 2)
        self.downButton.onStateChanged = scrollDown(buttonNode:)
        self.scrollbar.addChild(self.downButton)
        
        self.cropNode.maskNode = self.content
        addChild(self.cropNode)
        
        setScrollbarVisible(true)
    }
        
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    open func didScroll() {
        
    }
    
    private func scrollUp(buttonNode: ButtonNode) {
        print("up")
        
        if self.scrollDirection == .down { return }
        
        self.scrollDirection = buttonNode.isSelected ? .up : .none
    }
    
    private func scrollDown(buttonNode: ButtonNode) {
        print("down")

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
                let y = min(self.contentY + 1, max(self.size.height / 2, self.contentHeight / 2))
                if self.downButton.isEnabled == false { self.scrollDirection = .none }
                self.contentY = y
            case .up:
                let y = max(self.contentY - 1, self.size.height / 2)
                if self.upButton.isEnabled == false { self.scrollDirection = .none }
                self.contentY = y
            default: break
            }
            self.updateLayout()
        }
    }
    
    private func updateLayout() {
        guard let childNode = self.cropNode.children.first as? SKSpriteNode else { return }
        
        self.upButton.isEnabled = self.contentY != self.size.height / 2
        self.downButton.isEnabled = self.contentY != max(self.size.height / 2, self.contentHeight / 2)

        childNode.position = CGPoint(x: childNode.size.width / 2, y: self.contentY)
    }
}
