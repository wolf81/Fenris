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
        self.titleLabelMaxX = 0
        self.option = option
        self.height = height
        self.width = width
        
        self.label = SKLabelNode(text: option.title)
        self.label.horizontalAlignmentMode = .center
        self.label.verticalAlignmentMode = .center
        
        let font = try Font(name: self.label.fontName!, size: self.label.fontSize)
        let diff = font.maxHeight - (self.label.calculateAccumulatedFrame().height / 2)

        let labelWidth = (width != 0
            ? width
            : self.label.calculateAccumulatedFrame().width + ButtonNode.horizontalPadding * 2
        )
        
        let labelFrame = CGRect(
            x: 0,
            y: 0,
            width: labelWidth,
            height: height
        )
        
        super.init()
        
        self.path = CGPath(roundedRect: labelFrame, cornerWidth: 5, cornerHeight: 5, transform: nil)
        
        addChild(self.label)
        
        self.label.position = CGPoint(x: labelFrame.width / 2, y: diff + self.titleYOffset)
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
