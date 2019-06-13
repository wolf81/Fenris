//
//  ButtonNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 03/08/2018.
//  Copyright © 2018 Wolftrail. All rights reserved.
//

import SpriteKit

class ButtonNode: SKShapeNode, MenuNode {
    static var horizontalPadding: CGFloat = 8
    
    private var option: Button
    private var width: CGFloat
    
    private var label: SKLabelNode
    
    /// Create a button.
    ///
    /// - Parameters:
    ///   - option: The Button option.
    ///   - width: Optionally provide a width, when with is 0,
    //              it will be calculated based on the label.
    /// - Throws: Will throw an error if creation fails.
    init(option: Button, width: CGFloat = 0) throws {
        self.titleLabelMaxX = 0
        self.option = option
        self.width = width
        
        self.label = SKLabelNode(text: option.title)
        self.label.font = option.configuration.font
        self.label.horizontalAlignmentMode = .center
        self.label.verticalAlignmentMode = .baseline
        
        let font = Font(name: self.label.fontName!, size: self.label.fontSize)!
        let yOffset = ((self.option.configuration.height - font.maxHeight) / 2) +
            self.option.configuration.labelYOffset

        let labelWidth = (width != 0
            ? width
            : self.label.calculateAccumulatedFrame().width + ButtonNode.horizontalPadding * 2
        )
        
        let labelFrame = CGRect(
            x: 0,
            y: 0,
            width: labelWidth,
            height: self.option.configuration.height
        )
        
        super.init()
        
        self.path = CGPath(roundedRect: labelFrame, cornerWidth: 5, cornerHeight: 5, transform: nil)
        
        addChild(self.label)
        
        self.label.position = CGPoint(x: labelFrame.width / 2, y: yOffset)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func calculateAccumulatedFrame() -> CGRect {
        var rect = self.path?.boundingBox ?? CGRect.zero
        rect.size.width = rect.width + rect.origin.x
        rect.origin.x = 0
        rect.size.height = self.option.configuration.height
        return rect
    }
    
    // MARK: - MenuNode
    
    var titleLabelMaxX: CGFloat
    
    func interact(location: CGPoint) {
        self.option.selected()
    }
}
