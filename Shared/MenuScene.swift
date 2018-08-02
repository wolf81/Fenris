//
//  MenuScene.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 01/08/2018.
//  Copyright © 2018 Wolftrail. All rights reserved.
//

import SpriteKit

protocol TitleAlignableNode where Self: SKShapeNode {
    var titleLabelMaxX: CGFloat { get }
    var spacing: CGFloat { get }
}

public class MenuScene: SKScene {
    typealias MenuControl = SKShapeNode & TitleAlignableNode
    
    private var options: [MenuOption] = []
    
    private var controls: [MenuControl] = []
    
    private var alignControls = false

    public init(size: CGSize, options: [MenuOption]) {
        self.options = options
        
        super.init(size: size)
        
        addChildNodesForMenuOptions()
        layoutChildNodesForMenuOptions()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    private func addChildNodesForMenuOptions() {
        for option in self.options {
            switch option {
            case let label as Label:
                let node = LabelNode(title: label.title)
                addChild(node)
                self.controls.append(node)
            case let toggle as Toggle:
                let node = ToggleNode(title: option.title, checked: toggle.value)
                node.checked = toggle.value
                addChild(node)
                self.controls.append(node)
            case let numberPicker as NumberPicker:
                let node = NumberPickerNode(title: numberPicker.title, range: numberPicker.range, value: 0)
                addChild(node)
                self.controls.append(node)
            default:
                break
            }
        }
    }
    
    private func layoutChildNodesForMenuOptions() {
        let x: CGFloat = self.size.width / 2
        let y: CGFloat = self.size.height / 2
        
        let itemCountForHeight = fmaxf(Float(options.count - 1), 0)
        let totalHeight = CGFloat(itemCountForHeight * 100)
        let originY = y + (totalHeight / 2)
        
        for (idx, option) in options.enumerated().reversed() {
            let y = CGFloat(originY) - CGFloat(idx * 100)

            if let label = controlForMenuOption(option) {
                label.position = CGPoint(x: x - label.titleLabelMaxX, y: y)

                // When alignWithLastItem is set to true, we will align the last label in center
                //  and other labels to the right. The other labels will be positioned accordingly
                //  to be aligned with the last label.
                if alignControls && idx != (options.count - 1) {
                    
//                    if let lastLabel = labels.last {
//                        let xOffset = lastLabel.calculateAccumulatedFrame().maxX - x
//                        label.position = CGPoint(x: x + xOffset, y: y)
//                    }
//
//                    label.horizontalAlignmentMode = .right
                }
            }
        }
    }
    
    fileprivate func controlForMenuOption(_ option: MenuOption) -> MenuControl? {
        let idx = indexOfMenuOption(option)
        return idx != NSNotFound ? controls[idx] : nil
    }
    
    fileprivate func indexOfMenuOption(_ option: MenuOption) -> Int {
        var idx = NSNotFound
        
        for (testIdx, testOption) in options.enumerated() {
            if testOption === option {
                idx = testIdx
            }
        }
        
        return idx
    }
}
