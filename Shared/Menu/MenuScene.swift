//
//  MenuScene.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 15/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

public class MenuScene: SKScene, InputDeviceInteractable {
    private var focusItems: [FocusItem] = []
    
    private var focusItemIdx: Int = Int.min
    
    private var focusNode: FocusNode
    
    public init(size: CGSize, configuration: MenuConfiguration, menu: Menu) {
        self.focusNode = FocusNode(strokeColor: configuration.focusRectColor)
        super.init(size: size)

        let rowSize = CGSize(width: configuration.menuWidth, height: configuration.rowHeight)
        var menuRows: [MenuRowNode] = []
        
        for menuItemRow in menu.headerItems {
            let menuRow = MenuRowNode(size: rowSize, items: menuItemRow, font: configuration.titleFont)
            menuRows.append(menuRow)
        }

        for menuItemRow in menu.listItems {
            let menuRow = MenuRowNode(size: rowSize, items: menuItemRow, font: configuration.labelFont)
            menuRows.append(menuRow)
        }

        for menuItemRow in menu.footerItems {
            let menuRow = MenuRowNode(size: rowSize, items: menuItemRow, font: configuration.labelFont)
            menuRows.append(menuRow)
        }
        
        let menuHeight = menuRows.reduce(0) { $0 + $1.frame.size.height }

        var y = (size.height - menuHeight) / 2
        let x = ((size.width - configuration.menuWidth) / 2)
        for row in menuRows.reversed() {
            addChild(row)
            row.position = CGPoint(x: x, y: y)
            y += row.frame.size.height
        }
        
        // Create a list of focusable items
        for menuRowNode in menuRows {
            let interactableNodes = menuRowNode.itemNodes.filter({ $0 is InputDeviceInteractable }) as! [InputDeviceInteractable]
            
            switch interactableNodes.count {
            case 0: continue
            case 1:
                let focusItem = FocusItem(frame: menuRowNode.frame, interactableNode: interactableNodes[0])
                focusItems.append(focusItem)
            default:
                for interactableNode in interactableNodes {
                    let origin = menuRowNode.convert(interactableNode.frame.origin, to: self)
                    let size = interactableNode.frame.size
                    focusItems.append(FocusItem(frame: CGRect(origin: origin, size: size), interactableNode: interactableNode))
                }
            }
        }
        
        addChild(self.focusNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
        
    func handleInput(action: InputDeviceAction) {
        guard self.focusItems.count > 0 else { return }
        
        defer { showFocusNode() }
        
        guard self.focusItemIdx >= 0 else {
            return self.focusItemIdx = 0
        }
        
        guard self.focusNode.isHidden == false else {
            return
        }
        
        switch action {
        case _ where action.contains(.up):
            self.focusItemIdx = ((self.focusItemIdx - 1) >= 0)
                ? (self.focusItemIdx - 1)
                : self.focusItemIdx
        case _ where action.contains(.down):
            self.focusItemIdx = ((self.focusItemIdx + 1) < self.focusItems.count)
                ? (self.focusItemIdx + 1)
                : self.focusItemIdx
        case _ where action.contains(.left): fallthrough
        case _ where action.contains(.right): fallthrough
        case _ where action.contains(.buttonA): fallthrough
        case _ where action.contains(.buttonB):
            let focusItem = self.focusItems[self.focusItemIdx]
            focusItem.interactableNode.handleInput(action: action)
        default: break
        }
    }
    
    func showFocusNode() {
        self.focusNode.isHidden = false
        
        let focusItem = self.focusItems[self.focusItemIdx]
        self.focusNode.path = CGPath(rect: focusItem.frame, transform: nil)
    }
    
    fileprivate func hideFocusNode() {
        self.focusNode.isHidden = true
    }
}

#if os(macOS)

extension MenuScene {
    open override func mouseUp(with event: NSEvent) {
        let location = event.location(in: self)
        print("handle mouse click @ \(location)")
    }
    
    public override func mouseMoved(with event: NSEvent) {
        hideFocusNode()
    }

    open override func keyUp(with event: NSEvent) {
        switch event.keyCode {
        case 126: handleInput(action: .up)
        case 125: handleInput(action: .down)
        case 123: handleInput(action: .left)
        case 124: handleInput(action: .right)
        case 49: handleInput(action: .buttonA)
        case 53: handleInput(action: .buttonB)
        default: break
        }
    }
    
    open override func keyDown(with event: NSEvent) {
        // We override this method to silence the macOS beep on key press
    }
}

#endif

#if os(iOS)

extension MenuScene {
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: self)
        print("handle touch end @ \(location)")
    }
}

#endif
