//
//  NumberChooserNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 16/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import SpriteKit

public class NumberChooserNode: ChooserNode<Int>  {
    @objc public var fontName: String? {
        get { self.label.fontName }
        set { self.label.fontName = newValue ?? NumberChooserNode.appearance.fontName }
    }

    @objc public var fontSize: CGFloat {
        get { self.label.fontSize }
        set { self.label.fontSize = newValue }
    }

    @objc public var fontColor: SKColor? {
        get { self.label.fontColor }
        set { self.label.fontColor = newValue ?? NumberChooserNode.appearance.fontColor }
    }

    public override init(values: [Int], size: CGSize) {
        super.init(values: values, size: size)
          
        self.name = "NumberChooserNode"

        self.isLoopValuesEnabled = false
        
        self.fontName = NumberChooserNode.appearance.fontName
        self.fontSize = NumberChooserNode.appearance.fontSize
        self.fontColor = NumberChooserNode.appearance.fontColor

        NumberChooserNode.appearance.addObserver(self, forKeyPath: #keyPath(fontName), options: [.new], context: nil)
        NumberChooserNode.appearance.addObserver(self, forKeyPath: #keyPath(fontSize), options: [.new], context: nil)
        NumberChooserNode.appearance.addObserver(self, forKeyPath: #keyPath(fontColor), options: [.new], context: nil)
    }
    
    deinit {
        NumberChooserNode.appearance.removeObserver(self, forKeyPath: #keyPath(fontName))
        NumberChooserNode.appearance.removeObserver(self, forKeyPath: #keyPath(fontSize))
        NumberChooserNode.appearance.removeObserver(self, forKeyPath: #keyPath(fontColor))
    }

    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard object is Appearance else { return }

        switch keyPath {
        case #keyPath(Appearance.fontName): self.fontName = NumberChooserNode.appearance.fontName
        case #keyPath(Appearance.fontSize): self.fontSize = NumberChooserNode.appearance.fontSize
        case #keyPath(Appearance.fontColor): self.fontColor = NumberChooserNode.appearance.fontColor
        default: break
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}


