//
//  LabelNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 16/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import SpriteKit

public class LabelNode: ControlNode {
    @objc dynamic var label: SKLabelNode
    
    @objc public var fontName: String? {
        get { self.label.fontName }
        set { self.label.fontName = newValue ?? TextButtonNode.appearance.fontName }
    }
    
    @objc public var fontSize: CGFloat {
        get { self.label.fontSize }
        set { self.label.fontSize = newValue }
    }
    
    @objc public var fontColor: SKColor? {
        get { self.label.fontColor }
        set { self.label.fontColor = newValue ?? TextButtonNode.appearance.fontColor }
    }

    public init(text: String) {
        self.label = SKLabelNode(text: text)

        super.init()
    
        addChild(self.label)
        
        self.fontName = LabelNode.appearance.fontName
        self.fontSize = LabelNode.appearance.fontSize
        self.fontColor = LabelNode.appearance.fontColor
                    
        LabelNode.appearance.addObserver(self, forKeyPath: #keyPath(fontName), options: [.new], context: nil)
        LabelNode.appearance.addObserver(self, forKeyPath: #keyPath(fontSize), options: [.new], context: nil)
        LabelNode.appearance.addObserver(self, forKeyPath: #keyPath(fontColor), options: [.new], context: nil)
        
        let frame = self.label.calculateAccumulatedFrame()
        run(SKAction.resize(toWidth: frame.width, height: frame.height, duration: 0))
    }
    
    deinit {
        LabelNode.appearance.removeObserver(self, forKeyPath: #keyPath(fontName))
        LabelNode.appearance.removeObserver(self, forKeyPath: #keyPath(fontSize))
        LabelNode.appearance.removeObserver(self, forKeyPath: #keyPath(fontColor))
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

