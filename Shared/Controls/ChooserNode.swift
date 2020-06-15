//
//  ChooserNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 15/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import SpriteKit

public class ChooserNode<T: CustomStringConvertible>: SKSpriteNode & MenuItemNode {
    public var item: MenuItem = LabelItem(title: "bla")
    
    private var label: SKLabelNode
    
    private var leftButton: ButtonNode
    
    private var rightButton: ButtonNode
    
    private var selectedValueIndex: Int = 0
    
    var isLoopValuesEnabled: Bool = true {
        didSet {
            updateButtonState()
        }
    }
    
    let values: [T]

    override init(texture: SKTexture?, color: NSColor, size: CGSize) {        
        self.label = SKLabelNode()
        self.leftButton = ButtonNode(title: "◄", size: CGSize(width: 32, height: size.height))
        self.rightButton = ButtonNode(title: "►", size: CGSize(width: 32, height: size.height))
        self.values = []
        
        super.init(texture: texture, color: color, size: size)
    }
    
    init(values: [T], size: CGSize) {
        assert(values.count > 0, "The values array can not be empty")
        
        self.values = values
        
        self.label = SKLabelNode(text: "\(self.values.first!)")
        self.leftButton = ButtonNode(title: "◄", size: CGSize(width: 32, height: size.height))
        self.rightButton = ButtonNode(title: "►", size: CGSize(width: 32, height: size.height))

        super.init(texture: nil, color: .clear, size: size)
        
        self.label.position = CGPoint(x: 0, y: -(self.size.height - self.label.frame.height) / 2)
        self.label.verticalAlignmentMode = .baseline
        addChild(self.label)
        
        self.leftButton.position = CGPoint(x: -size.width / 2 + self.leftButton.size.width / 2, y: 0)
        self.leftButton.onStateChanged = { [unowned self] button in if button.isSelected { self.selectPreviousValue() }}
        addChild(self.leftButton)

        self.rightButton.position = CGPoint(x: size.width / 2 - self.rightButton.size.width / 2, y: 0)
        self.rightButton.onStateChanged = { [unowned self] button in if button.isSelected { self.selectNextValue() }}
        addChild(self.rightButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    private func selectNextValue() {
        if self.isLoopValuesEnabled {
            self.selectedValueIndex = (self.selectedValueIndex + 1) % self.values.count
            self.label.text = "\(self.values[self.selectedValueIndex])"
        } else {
            self.selectedValueIndex = min(self.selectedValueIndex + 1, self.values.count - 1)
            self.label.text = "\(self.values[self.selectedValueIndex])"
        }
        
        updateButtonState()
    }
    
    private func selectPreviousValue() {
        if self.isLoopValuesEnabled {
            self.selectedValueIndex = (self.selectedValueIndex - 1 + self.values.count) % self.values.count
            self.label.text = "\(self.values[self.selectedValueIndex])"
        } else {
            self.selectedValueIndex = max(self.selectedValueIndex - 1, 0)
            self.label.text = "\(self.values[self.selectedValueIndex])"
        }
        
        updateButtonState()
    }
    
    private func updateButtonState() {
        self.leftButton.isEnabled = self.isLoopValuesEnabled == true || self.selectedValueIndex > 0
        self.rightButton.isEnabled = self.isLoopValuesEnabled == true || self.selectedValueIndex < (self.values.count - 1)
    }
}

public class TextChooserNode: ChooserNode<String>   {
    init(size: CGSize, item: TextChooserItem, font: Font) {
        super.init(values: [], size: size)
    }
    
    public override init(values: [String], size: CGSize) {
        super.init(values: values, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

public class NumberChooserNode: ChooserNode<Int>  {
    init(size: CGSize, item: NumberChooserItem, font: Font) {
        super.init(values: [], size: size)
    }

    public override init(values: [Int], size: CGSize) {
        super.init(values: values, size: size)
        
        self.isLoopValuesEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}


