//
//  MenuScene.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 15/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

open class MenuScene: InputDeviceInteractableScene {
    fileprivate var focusItemController: FocusItemController!
    
    private var focusNode: FocusNode
    
    public override func didChangeInputScheme(_ inputScheme: InputDeviceScheme) {
        switch inputScheme {
        case .gamepad: self.showFocusNode()
        case .mouseKeyboard: self.hideFocusNode()
        case .touch: print("touch")
        case .tvRemote: print("tv remote")
        }
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
    
    public override func onInputActionChange(_ action: InputDeviceAction, isPressed: Bool) {
        switch action {
        case _ where action.contains(.up) && !isPressed: self.focusItemController.focusUp()
        case _ where action.contains(.down) && !isPressed: self.focusItemController.focusDown()
        case _ where action.contains(.left) && !isPressed: self.focusItemController.focusLeft()
        case _ where action.contains(.right) && !isPressed: self.focusItemController.focusRight()
        default:
            if isPressed {
                self.focusItemController.focusedItem?.interactableNode.handlePress(action)
            } else {
                self.focusItemController.focusedItem?.interactableNode.handleRelease(action)
            }
        }
    }
    
    open override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        if let pointUp = self.inputActions.getPointUp() {
            print("handle touch @ \(pointUp)")
            inputActions.removePointUp()
        } else if let pointMove = self.inputActions.getPointMove() {
            print("handle move @ \(pointMove)")
            let position = pointMove.cgPoint
        }

    }
    
//    public func handleInput(action: GameControllerAction) {
//        guard self.focusItemController.itemCount > 0 else {
//            return
//        }
//
//        // TODO: For footer we should probably allow left and right buttons for navigation
//        switch action {
//        case _ where action.contains(.pause): break
//        case _ where action.contains(.up): self.focusItemController.focusUp()
//        case _ where action.contains(.down): self.focusItemController.focusDown()
//        case _ where action.contains(.left): guard self.focusItemController.focusLeft() else { fallthrough }
//        case _ where action.contains(.right): guard self.focusItemController.focusRight() else { fallthrough }
//        case _ where action.contains(.buttonA): fallthrough
//        case _ where action.contains(.buttonB):
//            self.focusItemController.focusedItem?.interactableNode.handleInput(action: action)
//        default: break
//        }
//    }
    
    func showFocusNode() {
        guard let focusItem = self.focusItemController.focusedItem else { return }

        self.focusNode.isHidden = false
        self.focusNode.path = CGPath(rect: focusItem.frame, transform: nil)
    }

    fileprivate func hideFocusNode() {
        self.focusNode.isHidden = true
    }
    
//    public func handleMouseUp(location: CGPoint) {
//        guard let focusedNode = self.focusItemController.focusedItem?.interactableNode else {
//            return
//        }
//
//        let nodeLocation = convert(location, to: focusedNode)
//        focusedNode.handleMouseUp(location: nodeLocation)
//    }
//
//    public func handleMouseMoved(location: CGPoint) {
//        self.focusItemController.focusItem(at: location)
//    }
//
//    public func handleKeyUp(action: KeyboardAction) {
//        guard self.focusItemController.itemCount > 0 else {
//            return
//        }
//
//        switch action {
//        case _ where action.contains(.up): self.focusItemController.focusUp()
//        case _ where action.contains(.down): self.focusItemController.focusDown()
//        case _ where action.contains(.left): guard self.focusItemController.focusLeft() else { fallthrough }
//        case _ where action.contains(.right): guard self.focusItemController.focusRight() else { fallthrough }
//        case _ where action.contains(.action1): fallthrough
//        case _ where action.contains(.action2):
//            self.focusItemController.focusedItem?.interactableNode.handleKeyUp(action: action)
//        default: break
//        }
//    }
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
