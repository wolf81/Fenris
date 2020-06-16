//
//  ScrollbarNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 14/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import SpriteKit

class ScrollbarNode : SKSpriteNode {
    private static let buttonSize: CGSize = CGSize(width: 32, height: 32)
    
    let upButton: ButtonNode
    let downButton: ButtonNode
    let scroller: ButtonNode

    // value between 0 and 1?
    var scrollerY: CGFloat = 0 {
        didSet {
            let y = ((1.0 - self.scrollerY) * self.scrollAreaHeight) + ScrollbarNode.buttonSize.height * 3 / 2
            self.scroller.position = CGPoint(x: self.scroller.size.width / 2, y: y)
        }
    }
            
    private var scrollAreaHeight: CGFloat { self.size.height - ScrollbarNode.buttonSize.height * 3 }
    
    private var scrollerMinY: CGFloat { self.size.height }
    
    private var scrollerMaxY: CGFloat { 0 }
    
    public override init(texture: SKTexture?, color: SKColor, size: CGSize) {
        let bundle = Bundle(for: type(of: self))
        
        let upImage = bundle.image(forResource: "arrow-up")!
        let upTexture = SKTexture(image: upImage)
        self.upButton = ImageButtonNode(texture: upTexture, size: ScrollbarNode.buttonSize)
        
        let downImage = bundle.image(forResource: "arrow-down")!
        let downTexture = SKTexture(image: downImage)
        self.downButton = ImageButtonNode(texture: downTexture, size: ScrollbarNode.buttonSize)
        
        let scrollerImage = bundle.image(forResource: "scroller")!
        let scrollerTexture = SKTexture(image: scrollerImage)
        self.scroller = ImageButtonNode(texture: scrollerTexture, size: ScrollbarNode.buttonSize)
        
        // disable visual highlighting & selection for now by showing the texture for default state
        self.scroller.setTexture(texture: self.scroller.texture!, for: .highlighted)
        self.scroller.setTexture(texture: self.scroller.texture!, for: .selected)

        super.init(texture: texture, color: color, size: size)
                
        self.name = "ScrollbarNode"

        self.upButton.position = CGPoint(x: self.upButton.size.width / 2, y: size.height - self.upButton.size.height / 2)
        self.addChild(self.upButton)
        
        self.downButton.position = CGPoint(x: self.downButton.size.width / 2, y: self.downButton.size.height / 2)
        self.addChild(self.downButton)
        
        self.scroller.position = CGPoint(x: self.scroller.size.width / 2,
                                         y: self.scrollerMaxY)
        self.addChild(self.scroller)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }    
}
