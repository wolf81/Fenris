//
//  ProgressBarNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 17/04/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import SpriteKit

class ProgressBarNode: SKShapeNode, MenuItemNode {
    let item: MenuItem

    private var progressBarItem: ProgressBarItem { return self.item as! ProgressBarItem }

    private let bar: BarNode

    private let label: SKLabelNode
    
    init(size: CGSize, item: ProgressBarItem, font: Font) {
        self.item = item
        
        let barSize = CGSize(width: size.width, height: size.height / 3 * 2)
        
        self.bar = BarNode(size: barSize)
        self.bar.position = .zero

        self.label = SKLabelNode()
        self.label.font = font
        self.label.position = CGPoint(x: size.width / 2, y: (barSize.height - font.capHeight) / 2)

        super.init()
        
        self.path = CGPath(rect: CGRect(origin: CGPoint(x: 0, y: (size.height - barSize.height) / 2), size: size), transform: nil)
        self.lineWidth = 0

        addChild(self.bar)
        addChild(self.label)

        self.progressBarItem.addObserver(self, forKeyPath: #keyPath(ProgressBarItem.value), options: [.initial, .new], context: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    deinit {
        self.progressBarItem.removeObserver(self, forKeyPath: #keyPath(ProgressBarItem.value))
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if object is ProgressBarItem && keyPath == #keyPath(ProgressBarItem.value) {
            self.label.text = "\(Int(self.progressBarItem.value * 100)) %"
            self.bar.value = CGFloat(self.progressBarItem.value)
        }
    }
}
