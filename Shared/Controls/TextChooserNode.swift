//
//  TextChooserNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 16/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import Foundation
import SpriteKit

public class TextChooserNode: ChooserNode<String>   {
    @objc public var fontName: String? {
        get { self.label.fontName }
        set { self.label.fontName = newValue ?? TextChooserNode.appearance.fontName }
    }

    @objc public var fontSize: CGFloat {
        get { self.label.fontSize }
        set { self.label.fontSize = newValue }
    }

    @objc public var fontColor: SKColor? {
        get { self.label.fontColor }
        set { self.label.fontColor = newValue ?? TextChooserNode.appearance.fontColor }
    }

    init(size: CGSize, item: TextChooserItem, font: Font) {
        super.init(values: ["Hi"], size: size)
    }
    
    public override init(values: [String], size: CGSize) {
        super.init(values: values, size: size)

        self.name = "TextChooserNode"

        self.fontName = TextChooserNode.appearance.fontName
        self.fontSize = TextChooserNode.appearance.fontSize
        self.fontColor = TextChooserNode.appearance.fontColor

        TextChooserNode.appearance.addObserver(self, forKeyPath: #keyPath(fontName), options: [.new], context: nil)
        TextChooserNode.appearance.addObserver(self, forKeyPath: #keyPath(fontSize), options: [.new], context: nil)
        TextChooserNode.appearance.addObserver(self, forKeyPath: #keyPath(fontColor), options: [.new], context: nil)
    }

    deinit {
        TextChooserNode.appearance.removeObserver(self, forKeyPath: #keyPath(fontName))
        TextChooserNode.appearance.removeObserver(self, forKeyPath: #keyPath(fontSize))
        TextChooserNode.appearance.removeObserver(self, forKeyPath: #keyPath(fontColor))
    }

    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard object is Appearance else { return }

        switch keyPath {
        case #keyPath(Appearance.fontName): self.fontName = TextChooserNode.appearance.fontName
        case #keyPath(Appearance.fontSize): self.fontSize = TextChooserNode.appearance.fontSize
        case #keyPath(Appearance.fontColor): self.fontColor = TextChooserNode.appearance.fontColor
        default: break
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
