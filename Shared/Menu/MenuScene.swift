//
//  MenuScene.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 15/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

open class MenuScene: SKScene, InputDeviceInteractable {
    fileprivate var focusItems: [FocusItem] = []
    
    private var focusItemIdx: Int = Int.min {
        didSet {
            if self.focusItemIdx == Int.min {
                hideFocusNode()
            } else {
                showFocusNode()
            }
        }
    }
    
    private var focusNode: FocusNode
    
    private var focusedItem: FocusItem? {
        guard self.focusItemIdx != Int.min else { return nil }
        return self.focusItems[self.focusItemIdx]
    }
        
    public init(size: CGSize, configuration: MenuConfiguration, menu: Menu) {
        self.focusNode = FocusNode(strokeColor: configuration.focusRectColor)
        super.init(size: size)

        let rowSize = CGSize(width: configuration.menuWidth, height: configuration.rowHeight)
        var menuRows: [MenuRowNode] = []
        
        let headerRow = MenuRowNode(size: rowSize, items: menu.headerItems, font: configuration.titleFont)
        menuRows.append(headerRow)

        for menuItemRow in menu.listItems {
            let menuRow = MenuRowNode(size: rowSize, items: menuItemRow, font: configuration.labelFont)
            menuRows.append(menuRow)
        }

        let footerRow = MenuRowNode(size: rowSize, items: menu.footerItems, font: configuration.labelFont)
        menuRows.append(footerRow)

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
                self.focusItems.append(focusItem)
            default:
                for interactableNode in interactableNodes {
                    let origin = menuRowNode.convert(interactableNode.frame.origin, to: self)
                    let size = interactableNode.frame.size
                    self.focusItems.append(FocusItem(frame: CGRect(origin: origin, size: size), interactableNode: interactableNode))
                }
            }
        }
        
        addChild(self.focusNode)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }
        
    func handleInput(action: GameControllerAction) {
        guard self.focusItems.count > 0 else { return }
        
        defer { showFocusNode() }
        
        guard self.focusItemIdx >= 0 else {
            return self.focusItemIdx = 0
        }
        
        guard self.focusNode.isHidden == false else {
            return
        }
        
        switch action {
        case _ where action.contains(.up): focusPrevious()
        case _ where action.contains(.down): focusNext()
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
    
    private func focusPrevious() {
        self.focusItemIdx = ((self.focusItemIdx - 1) >= 0)
            ? (self.focusItemIdx - 1)
            : self.focusItemIdx
    }
    
    private func focusNext() {
        self.focusItemIdx = ((self.focusItemIdx + 1) < self.focusItems.count)
            ? (self.focusItemIdx + 1)
            : self.focusItemIdx
    }
    
    fileprivate func hideFocusNode() {
        self.focusNode.isHidden = true
    }
    
    func handleMouseUp(location: CGPoint) {
        guard let focusedNode = self.focusedItem?.interactableNode else {
            return
        }
        
        let nodeLocation = convert(location, to: focusedNode)
        focusedNode.handleMouseUp(location: nodeLocation)
    }
    
    func handleMouseMoved(location: CGPoint) {
        self.focusItemIdx = Int.min
        
        for (idx, focusItem) in self.focusItems.enumerated() {
            if focusItem.frame.contains(location) {
                self.focusItemIdx = idx
                break
            }
        }
    }
    
    func handleKeyUp(action: KeyboardAction) {
        guard self.focusItems.count > 0 else { return }
        
        defer { showFocusNode() }
        
        guard self.focusItemIdx >= 0 else {
            return self.focusItemIdx = 0
        }
        
        guard self.focusNode.isHidden == false else {
            return
        }
        
        switch action {
        case _ where action.contains(.up): focusPrevious()
        case _ where action.contains(.down): focusNext()
        case _ where action.contains(.left): fallthrough
        case _ where action.contains(.right): fallthrough
        case _ where action.contains(.action1): fallthrough
        case _ where action.contains(.action2):
            let focusItem = self.focusItems[self.focusItemIdx]
            focusItem.interactableNode.handleKeyUp(action: action)
        default: break
        }
    }
}

#if os(macOS)

extension MenuScene {
    open override func mouseUp(with event: NSEvent) {
        let location = event.location(in: self)
        handleMouseUp(location: location)
    }
    
    open override func mouseMoved(with event: NSEvent) {
        let location = event.location(in: self)
        handleMouseMoved(location: location)
    }

    open override func keyUp(with event: NSEvent) {
        // TODO: A keymap file might be used bind key codes with key actions, this could be part of
        // the app settings and provide a default implementation that can be changed
        
        switch event.keyCode {
        case 126: handleKeyUp(action: .up)
        case 125: handleKeyUp(action: .down)
        case 123: handleKeyUp(action: .left)
        case 124: handleKeyUp(action: .right)
        case 49: handleKeyUp(action: .action1)
        case 53: handleKeyUp(action: .action2)
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
