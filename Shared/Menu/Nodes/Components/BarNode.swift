//
//  BarNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 17/04/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import SpriteKit

class BarNode: SKShapeNode {
    var value: CGFloat = 0 {
        didSet {
            updateBarFill()
        }
    }
    
    private var barFill = SKShapeNode()
    
    init(size: CGSize) {
        super.init()
                
        self.strokeColor = .white
        self.fillColor = .clear
        self.lineWidth = 1
        self.isAntialiased = true
        
        self.path = CGPath(roundedRect: CGRect(origin: .zero, size: size), cornerWidth: size.height / 2, cornerHeight: size.height / 2, transform: nil)
        
        let maskHeight = size.height - 8
        let maskWidth = size.width - 8
        let maskNode = SKShapeNode(rect: CGRect(origin: CGPoint(x: (size.width - maskWidth) / 2, y: (size.height - maskHeight) / 2),
                                                size: CGSize(width: maskWidth, height: maskHeight)), cornerRadius: maskHeight / 2)
        maskNode.fillColor = SKColor.white
        maskNode.strokeColor = SKColor.clear
        
        let cropNode = SKCropNode()
        cropNode.maskNode = maskNode
        cropNode.addChild(self.barFill)
        self.barFill.fillColor = SKColor.white.withAlphaComponent(0.3)
        self.barFill.strokeColor = SKColor.clear
        self.barFill.lineWidth = 0
        addChild(cropNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Private
    
    private func updateBarFill() {
        self.barFill.path = CGPath(rect: CGRect(origin: .zero, size: CGSize(width: self.frame.width * value, height: self.frame.height)), transform: nil)
    }
}
