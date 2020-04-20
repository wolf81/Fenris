//
//  MenuScene.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 15/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

open class MenuSceneBase: SKScene, SceneManagerConstructable {
    
    /// Use this method to configure the menu items, this method must be implemented by subclasses.
    open func getMenu() -> Menu { fatalError()}
    
    /// Use this method to configure the menu layout, this method must be implemented by subclasses.
    open var configuration: MenuConfiguration { get { fatalError() } }
    
    internal var focusItemController: FocusItemController!
    
    internal var focusNode: FocusNode!
    
    private var menuRows: [MenuRowNode] = []
        
    private let userInfo: [String: Any]
    
    internal var menuItemNodes: [MenuItemNode] { return self.menuRows.compactMap({ $0.itemNodes }).reduce([], +) }

    open override func didMove(to view: SKView) {
        super.didMove(to: view)
    
        initializeInputDeviceManagerIfNeeded(scene: self, onInputDeviceChanged: { scheme in
            switch scheme {
            case .gamepad: self.showFocusNode()
            case .mouseKeyboard: self.hideFocusNode()
            case .touch: self.hideFocusNode()
            case .tvRemote: self.showFocusNode()
            }
        })
    }
        
    open override func sceneDidLoad() {
        super.sceneDidLoad()
        
        updateMenu()
    }
    
    public required init(size: CGSize, userInfo: [String : Any]) {
        self.userInfo = userInfo
                
        super.init(size: size)
                
        self.focusNode = FocusNode(strokeColor: self.configuration.focusRectColor)
        self.focusNode.zPosition = 1_000

        addChild(self.focusNode)
        
        self.focusItemController = FocusItemController(menuRowNodes: self.menuRows, parentNode: self, delegate: self)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }
        
    fileprivate func showFocusNode() {
        guard let focusItem = self.focusItemController.focusedItem else { return }

        self.focusNode.isHidden = false
        
        if focusItem.interactableNode.parent is MenuFooterNode {
            print("in footer")
        }
        
        self.focusNode.path = CGPath(rect: focusItem.frame, transform: nil)
    }

    fileprivate func hideFocusNode() {
        self.focusNode.isHidden = true
    }
    
    internal func updateMenu() {
        let menu = getMenu()
        
        let rowSize = CGSize(width: self.configuration.menuWidth, height: self.configuration.rowHeight)
        
        let headerRow = MenuRowNode(size: rowSize, items: menu.headerItems, font: self.configuration.titleFont, footerMinimumHorizontalSpacing: self.configuration.footerMinimumHorizontalSpacing)
        self.menuRows.append(headerRow)

        for menuItemRow in menu.listItems {
            let menuRow = MenuRowNode(size: rowSize, items: menuItemRow, font: self.configuration.labelFont, footerMinimumHorizontalSpacing: self.configuration.footerMinimumHorizontalSpacing)
            self.menuRows.append(menuRow)
        }

        let footerRow = MenuRowNode(size: rowSize, items: menu.footerItems, font: self.configuration.labelFont, footerMinimumHorizontalSpacing: self.configuration.footerMinimumHorizontalSpacing)
        self.menuRows.append(footerRow)

        let menuHeight = self.menuRows.reduce(0) { $0 + $1.frame.size.height }

        var y = (size.height - menuHeight) / 2
        let x = ((size.width - self.configuration.menuWidth) / 2)
        for row in self.menuRows.reversed() {
            addChild(row)
            row.position = CGPoint(x: x, y: y)
            y += row.frame.size.height
        }

        self.focusItemController = FocusItemController(menuRowNodes: self.menuRows, parentNode: self, delegate: self)
    }
}

// MARK: - InputDeviceInteractable

extension MenuSceneBase: InputDeviceInteractable {
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

// MARK: - FocusItemControllerDelegate

extension MenuSceneBase: FocusItemControllerDelegate {
    func focusItemController(_ controller: FocusItemController, didChangeFocusedItem focusItem: FocusItem?) {
        if focusItem == nil {
            hideFocusNode()
        } else {
            showFocusNode()
        }
    }
}

#if os(macOS)

extension MenuSceneBase {
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
