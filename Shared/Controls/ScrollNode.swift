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
    
    private var contentHeight: CGFloat = 0
    
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
    
    private var contentY: CGFloat = 0

    public func addContent(sprite: SKSpriteNode) {
        self.contentHeight = sprite.size.height
        self.contentY = self.content.size.height
        
        sprite.anchorPoint = CGPoint(x: 0, y: 1)
        sprite.position = CGPoint(x: 0, y: self.contentY)
        self.cropNode.addChild(sprite)
    }
    
    public override init(texture: SKTexture?, color: NSColor, size: CGSize) {
        let buttonSize = CGSize(width: 32, height: 32)

        self.cropNode = SKCropNode()
        self.contentHeight = size.height
        
        let contentSize = CGSize(width: size.width - buttonSize.width, height: size.height)
        self.content = SKSpriteNode(texture: nil, color: .lightGray, size: contentSize)
        self.scrollbar = SKSpriteNode(texture: nil, color: .orange, size: CGSize(width: buttonSize.width, height: size.height - buttonSize.height * 2))
        self.upButton = ButtonNode(title: "u", size: buttonSize)
        self.downButton = ButtonNode(title: "d", size: buttonSize)
        
        super.init(texture: texture, color: color, size: size)
        
        self.content.anchorPoint = .zero
        self.content.position = .zero
        addChild(self.content)
        
        self.scrollbar.anchorPoint = CGPoint.zero
        self.scrollbar.position = CGPoint(x: size.width - self.scrollbar.size.width, y: buttonSize.height)
        addChild(self.scrollbar)
        
        self.upButton.onHighlighted = scrollUp(buttonNode:)
        self.upButton.onSelected = cancelScroll(buttonNode:)
        self.upButton.position = CGPoint(x: size.width - buttonSize.width / 2, y: size.height - buttonSize.height / 2)
        addChild(upButton)
        
        self.downButton.position = CGPoint(x: size.width - buttonSize.width / 2, y: buttonSize.height / 2)
        self.downButton.onSelected = cancelScroll(buttonNode:)
        self.downButton.onHighlighted = scrollDown(buttonNode:)
        addChild(self.downButton)
        
        self.cropNode.maskNode = self.content
        addChild(self.cropNode)
        
        setScrollbarVisible(false)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    private func cancelScroll(buttonNode: ButtonNode) {
        self.scrollDirection = .none
    }
    
    private func scrollUp(buttonNode: ButtonNode) {
        print("up")        
        self.scrollDirection = .up
    }
    
    private func scrollDown(buttonNode: ButtonNode) {
        print("down")
        self.scrollDirection = .down
    }
    
    private func setScrollbarVisible(_ isVisible: Bool) {
        self.upButton.alpha = isVisible ? 1.0 : 0.0
        self.downButton.alpha = isVisible ? 1.0 : 0.0
        self.scrollbar.alpha = isVisible ? 1.0 : 0.0
    }
    
    @objc private func performAutoscroll() {
        DispatchQueue.main.async { [unowned self] in
            switch self.scrollDirection {
            case .down:
                self.contentY = min(self.contentY + 1, self.contentHeight)
            case .up:
                self.contentY = max(self.contentY - 1, self.content.size.height)
            default: break
            }
            self.updateLayout()
        }
    }
    
    private func updateLayout() {
        guard let childNode = self.cropNode.children.first else { return }
        
        childNode.position = CGPoint(x: 0, y: self.contentY)
    }
}
