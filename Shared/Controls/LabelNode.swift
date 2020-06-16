//
//  LabelNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 16/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import SpriteKit

public class LabelNode: SKLabelNode, MenuItemNode {
    public let item: MenuItem
    
    public init(size: CGSize, item: LabelItem, font: Font) {
        self.item = item
        
        super.init()
    }
    
    public init(text: String) {
        self.item = LabelItem(title: "")
        
        super.init()
        
        self.text = text

        self.fontName = LabelNode.appearance.fontName
        self.fontSize = LabelNode.appearance.fontSize
        self.fontColor = LabelNode.appearance.fontColor
                    
        LabelNode.appearance.addObserver(self, forKeyPath: #keyPath(fontName), options: [.new], context: nil)
        LabelNode.appearance.addObserver(self, forKeyPath: #keyPath(fontSize), options: [.new], context: nil)
        LabelNode.appearance.addObserver(self, forKeyPath: #keyPath(fontColor), options: [.new], context: nil)
    }
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard object is Appearance else { return }

        switch keyPath {
        case #keyPath(Appearance.fontName): self.fontName = LabelNode.appearance.fontName
        case #keyPath(Appearance.fontSize): self.fontSize = LabelNode.appearance.fontSize
        case #keyPath(Appearance.fontColor): self.fontColor = LabelNode.appearance.fontColor
        default: break
        }
    }
        
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

