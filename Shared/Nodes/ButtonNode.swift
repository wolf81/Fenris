//
//  ButtonNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 03/08/2018.
//  Copyright © 2018 Wolftrail. All rights reserved.
//

import SpriteKit

class ButtonNode: SKShapeNode, MenuNode {
    var titleLabelMaxX: CGFloat
    
    static var horizontalPadding: CGFloat = 8
    
    private var height: CGFloat
    private var width: CGFloat
    private var option: Button?
    
    var spacing: CGFloat {
        return 0
    }
    
    func interact(location: CGPoint) {
        guard let option = self.option else {
            return
        }
        option.selected()
    }
    
    private var label: SKLabelNode
    
    init(option: Button, height: CGFloat, width: CGFloat = 0) throws {
        self.option = option
        
        self.height = height
        self.width = width
        
        self.label = SKLabelNode(text: option.title)
        self.label.horizontalAlignmentMode = .center
        self.label.verticalAlignmentMode = .center
        
        let font = try Font(name: self.label.fontName!, size: self.label.fontSize)
        let diff = (font.maxHeight - label.calculateAccumulatedFrame().height) / 2

        var frame = self.label.calculateAccumulatedFrame()
        frame.size.width += ButtonNode.horizontalPadding * 2
        if width != 0 {
            frame.size.width = width + ButtonNode.horizontalPadding * 2
        }
        frame = CGRect(origin: CGPoint.zero, size: CGSize(width: frame.width, height: height))
        
        self.titleLabelMaxX = 0
        
        super.init()
        
        self.path = CGPath(roundedRect: frame, cornerWidth: 5, cornerHeight: 5, transform: nil)
        
        let frameWidth = self.calculateAccumulatedFrame().width
        let labelWidth = self.label.calculateAccumulatedFrame().width
        let x = self.calculateAccumulatedFrame().minX + (frameWidth - labelWidth) / 2
        self.label.position = CGPoint(x: frame.width / 2, y: diff + font.maxHeight / 2 + self.titleYOffset)

        addChild(self.label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func calculateAccumulatedFrame() -> CGRect {
        var rect = self.path?.boundingBox ?? CGRect.zero
        rect.size.width = rect.width + rect.origin.x
        rect.origin.x = 0
        rect.size.height = self.height
        return rect
    }
}
