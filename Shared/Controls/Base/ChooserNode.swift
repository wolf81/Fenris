//
//  ChooserNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 15/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import SpriteKit

public class ChooserNode<T: CustomStringConvertible>: ControlNode {
    internal let label: SKLabelNode
    
    private var leftButton: ButtonNode
    
    private var rightButton: ButtonNode
    
    public var selectedValueIndex: Int = 0 {
        didSet {
            let validRange = 0 ..< self.values.count
            assert(validRange.contains(self.selectedValueIndex), "selectedValueIndex \(self.selectedValueIndex) ouf of range \(validRange)")
            update()
        }
    }
    
    public var isLoopValuesEnabled: Bool = true {
        didSet {
            update()
        }
    }
    
    let values: [T]
    
    init(values: [T], size: CGSize) {
        assert(values.count > 0, "The values array can not be empty")
        
        self.values = values
        
        let bundle = Bundle(for: type(of: self))
        let leftImage = bundle.image(forResource: "arrow-left")!
        let leftTexture = SKTexture(image: leftImage)
        
        let rightImage = bundle.image(forResource: "arrow-right")!
        let rightTexture = SKTexture(image: rightImage)

        self.label = SKLabelNode(text: "\(self.values.first!)")
        self.leftButton = ImageButtonNode(texture: leftTexture, size: CGSize(width: 32, height: size.height))
        self.rightButton = ImageButtonNode(texture: rightTexture, size: CGSize(width: 32, height: size.height))

        super.init(size: size)
        
        self.label.position = CGPoint(x: 0, y: -(self.size.height - self.label.frame.height) / 2)
        self.label.verticalAlignmentMode = .baseline
        addChild(self.label)
        
        self.leftButton.position = CGPoint(x: -size.width / 2 + self.leftButton.size.width / 2, y: 0)
        self.leftButton.onSelected = { [unowned self] _ in self.selectPreviousValue() }
        addChild(self.leftButton)

        self.rightButton.position = CGPoint(x: size.width / 2 - self.rightButton.size.width / 2, y: 0)
        self.rightButton.onSelected = { [unowned self] _ in self.selectNextValue() }
        addChild(self.rightButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    private func selectNextValue() {
        if self.isLoopValuesEnabled {
            self.selectedValueIndex = (self.selectedValueIndex + 1) % self.values.count
        } else {
            self.selectedValueIndex = min(self.selectedValueIndex + 1, self.values.count - 1)
        }
        
        update()
    }
    
    private func selectPreviousValue() {
        if self.isLoopValuesEnabled {
            self.selectedValueIndex = (self.selectedValueIndex - 1 + self.values.count) % self.values.count
        } else {
            self.selectedValueIndex = max(self.selectedValueIndex - 1, 0)
        }
        
        update()
    }
    
    private func update() {
        self.label.text = "\(self.values[self.selectedValueIndex])"

        self.leftButton.isEnabled = self.isLoopValuesEnabled == true || self.selectedValueIndex > 0
        self.rightButton.isEnabled = self.isLoopValuesEnabled == true || self.selectedValueIndex < (self.values.count - 1)
    }
}

