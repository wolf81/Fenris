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
    
    public init(size: CGSize, menu: Menu) {
        self.focusNode = FocusNode(strokeColor: menu.configuration.focusRectColor)
        super.init(size: size)

        assert(menu.items.count.isMultiple(of: 2), "Menu should contain an even amount of items")
        
        var menuRows: [MenuRowNode] = []
        
        let rowSize = CGSize(width: menu.configuration.menuWidth, height: menu.configuration.rowHeight)
        if let menuTitle = menu.title {
            let headerItem = LabelItem(title: menuTitle)
            menuRows.append(MenuRowNode(size: rowSize, items: [headerItem], font: menu.configuration.titleFont))
        }
        
        let rowCount = menu.items.count / 2
        for rowIdx in (0 ..< rowCount) {
            let firstItem = menu.items[rowIdx * 2]
            let secondItem = menu.items[rowIdx * 2 + 1]
            let menuRowNode = MenuRowNode(size: rowSize, items: [firstItem, secondItem], font: menu.configuration.labelFont)
            menuRows.append(menuRowNode)
        }
        
        let menuRowNode = MenuRowNode(size: rowSize, items: menu.footerItems, font: menu.configuration.labelFont)
        menuRows.append(menuRowNode)

        let tableHeight: CGFloat = CGFloat(1 + rowCount + ((menu.footerItems.count > 0) ? 1 : 0)) * menu.configuration.rowHeight
        var y = (size.height - tableHeight) / 2
        let x = ((size.width - menu.configuration.menuWidth) / 2)
        for row in menuRows.reversed() {
            addChild(row)
            row.position = CGPoint(x: x, y: y)
            y += menu.configuration.rowHeight
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
