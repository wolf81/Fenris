//
//  MenuScene.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 15/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

open class MenuScene: SKScene {
    fileprivate var focusItemController: FocusItemController!
    
    private var focusNode: FocusNode

    open override func didMove(to view: SKView) {
        super.didMove(to: view)
    
        initializeInputDeviceManagerIfNeeded(scene: self, onInputDeviceChanged: { scheme in
            switch scheme {
            case .gamepad: self.showFocusNode()
            case .mouseKeyboard: self.hideFocusNode()
            case .touch: print("touch")
            case .tvRemote: print("tv remote")
            }
        })
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

        self.focusItemController = FocusItemController(menuRowNodes: menuRows, parentNode: self)
        self.focusItemController.delegate = self
        
        addChild(self.focusNode)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }
        
    fileprivate func showFocusNode() {
        guard let focusItem = self.focusItemController.focusedItem else { return }

        self.focusNode.isHidden = false
        self.focusNode.path = CGPath(rect: focusItem.frame, transform: nil)
    }

    fileprivate func hideFocusNode() {
        self.focusNode.isHidden = true
    }
}

extension MenuScene: InputDeviceInteractable {
    public func handleInput(action: GameControllerAction) {
        guard self.focusItemController.itemCount > 0 else {
            return
        }
        
        switch action {
        case _ where action.contains(.pause): break
        case _ where action.contains(.up): self.focusItemController.focusUp()
        case _ where action.contains(.down): self.focusItemController.focusDown()
        case _ where action.contains(.left): guard self.focusItemController.focusLeft() else { fallthrough }
        case _ where action.contains(.right): guard self.focusItemController.focusRight() else { fallthrough }
        case _ where action.contains(.buttonA): fallthrough
        case _ where action.contains(.buttonB):
            self.focusItemController.focusedItem?.interactableNode.handleInput(action: action)
        default: break
        }
    }
    
    public func handleMouseUp(location: CGPoint) {
        guard let focusedNode = self.focusItemController.focusedItem?.interactableNode else {
            return
        }
        
        let nodeLocation = convert(location, to: focusedNode)
        focusedNode.handleMouseUp(location: nodeLocation)
    }
    
    public func handleMouseMoved(location: CGPoint) {
        self.focusItemController.focusItem(at: location)
    }
    
    public func handleKeyUp(action: KeyboardAction) {
        guard self.focusItemController.itemCount > 0 else {
            return
        }

        switch action {
        case _ where action.contains(.up): self.focusItemController.focusUp()
        case _ where action.contains(.down): self.focusItemController.focusDown()
        case _ where action.contains(.left): guard self.focusItemController.focusLeft() else { fallthrough }
        case _ where action.contains(.right): guard self.focusItemController.focusRight() else { fallthrough }
        case _ where action.contains(.action1): fallthrough
        case _ where action.contains(.action2):
            self.focusItemController.focusedItem?.interactableNode.handleKeyUp(action: action)
        default: break
        }
    }
}

extension MenuScene: FocusItemControllerDelegate {
    func focusItemController(_ controller: FocusItemController, didChangeFocusedItem focusItem: FocusItem?) {
        if focusItem == nil {
            hideFocusNode()
        } else {
            showFocusNode()
        }
    }
}

#if os(macOS)

extension MenuScene {
    open override func mouseUp(with event: NSEvent) {
        guard
            let inputDeviceManager = try? ServiceLocator.shared.get(service: InputDeviceManager.self),
            inputDeviceManager.scheme == .mouseKeyboard else {
                return
        }

        let location = event.location(in: self)
        handleMouseUp(location: location)
    }
    
    open override func mouseMoved(with event: NSEvent) {
        guard
            let inputDeviceManager = try? ServiceLocator.shared.get(service: InputDeviceManager.self),
            inputDeviceManager.scheme == .mouseKeyboard else {
                return
        }

        let location = event.location(in: self)
        handleMouseMoved(location: location)
    }

    open override func keyUp(with event: NSEvent) {
        guard
            let inputDeviceManager = try? ServiceLocator.shared.get(service: InputDeviceManager.self),
            inputDeviceManager.scheme == .mouseKeyboard else {
                return
        }

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
        guard
            let inputDeviceManager = try? ServiceLocator.shared.get(service: InputDeviceManager.self),
            inputDeviceManager.scheme == .mouseKeyboard else {
                return
        }

        // We override this method to silence the macOS beep on key press
    }
}

#endif
