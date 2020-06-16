//
//  TextButtonNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 15/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import SpriteKit

open class TextButtonNode: ButtonNode {
    private var label: SKLabelNode

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

    public init(title: String, size: CGSize, onStateChanged: ((ButtonNode) -> ())? = nil) {
        self.label = SKLabelNode(text: title)

        super.init(size: size, onStateChanged: onStateChanged)
                
        self.name = "TextButtonNode \"\(title)\""
        
        self.label.position = CGPoint(x: 0, y: -(self.size.height / 4))
        self.label.verticalAlignmentMode = .baseline        
        addChild(self.label)

        self.fontName = TextButtonNode.appearance.fontName
        self.fontSize = TextButtonNode.appearance.fontSize
        self.fontColor = TextButtonNode.appearance.fontColor
                    
        TextButtonNode.appearance.addObserver(self, forKeyPath: #keyPath(fontName), options: [.new], context: nil)
        TextButtonNode.appearance.addObserver(self, forKeyPath: #keyPath(fontSize), options: [.new], context: nil)
        TextButtonNode.appearance.addObserver(self, forKeyPath: #keyPath(fontColor), options: [.new], context: nil)
    }
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard object is Appearance else { return }

        switch keyPath {
        case #keyPath(Appearance.fontName): self.fontName = TextButtonNode.appearance.fontName
        case #keyPath(Appearance.fontSize): self.fontSize = TextButtonNode.appearance.fontSize
        case #keyPath(Appearance.fontColor): self.fontColor = TextButtonNode.appearance.fontColor
        default: break
        }
    }
        
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
