//
//  MenuScene.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 01/08/2018.
//  Copyright © 2018 Wolftrail. All rights reserved.
//

import SpriteKit

public class MenuScene: SKScene {
    typealias MenuControl = SKShapeNode & MenuNode
    
    private var verticalPadding: CGFloat = 0
    
    private var font: Font
    
    private var options: [MenuOption] = []
    
    private var controls: [MenuControl] {
        var nodes: [MenuControl] = []
        for node in self.children where node is MenuControl {
            nodes.append(node as! MenuControl)
        }
        return nodes
    }
        
    public init(size: CGSize, controlHeight: CGFloat, options: [MenuOption]) {
        self.options = options
        
        self.font = try! Font(name: "Papyrus", size: 14)
        
        super.init(size: size)

        self.verticalPadding = self.size.height / 4

        addChildNodesForMenuOptions(nodeHeight: controlHeight)
        layoutChildNodesForMenuOptions()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    private func addChildNodesForMenuOptions(nodeHeight: CGFloat) {
        for option in self.options {
            do {
                let node = try MenuNodeFactory.menuNodeFor(option: option,
                                                           nodeHeight: nodeHeight)
                addChild(node)
            } catch let error {
                print("[ERROR] \(error.localizedDescription)")
            }
        }
    }
    
    private func layoutChildNodesForMenuOptions() {
        let x: CGFloat = self.frame.midX
        let count = max((self.options.count - 1), 1)
        let spacing = (self.size.height - self.verticalPadding * 2) / CGFloat(count)
        
        var y = self.verticalPadding
        for option in self.options.reversed() {
            guard let control = controlForMenuOption(option) else {
                continue
            }
            
            let yOffset = -(control.calculateAccumulatedFrame().height / 2)
            var xOffset = -(control.titleLabelMaxX)
            if control is ButtonNode {
                xOffset -= control.calculateAccumulatedFrame().width
            }

            control.position = CGPoint(x: x + xOffset, y: y + yOffset)
            
            y += spacing
        }
    }
    
    fileprivate func controlForMenuOption(_ option: MenuOption) -> MenuControl? {
        let idx = indexOfMenuOption(option)
        return idx != NSNotFound ? self.controls[idx] : nil
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

    func menuControlAt(location: CGPoint) -> MenuControl? {
        let nodes = self.nodes(at: location)

        for node in nodes.reversed() {
            if node is MenuControl {
                return (node as! MenuControl)
            }
        }
        
        return nil
    }
}

#if os(macOS)

extension MenuScene {
    public override func mouseUp(with event: NSEvent) {
        var location = event.location(in: self)
        if let control = menuControlAt(location: location) {
           location = self.convert(location, to: control)
            control.interact(location: location)
        }
    }
}

#endif

#if os(iOS)

extension MenuScene {
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        var location = touch.location(in: self)
        if let control = menuControlAt(location: location) {
            location = self.convert(location, to: control)
            control.interact(location: location)
        }
    }
}

#endif
