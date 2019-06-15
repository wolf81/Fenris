//
//  MenuScene.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 15/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

public class MenuScene: SKScene, InputDeviceInteractable {
    public init(size: CGSize, menu: MenuBuilder.Menu) {
        super.init(size: size)

        assert(menu.items.count.isMultiple(of: 2), "Menu should contain an even amount of items")
        
        var menuRows: [MenuRowNode] = []
        
        let rowSize = CGSize(width: menu.configuration.menuWidth, height: menu.configuration.rowHeight)
        let headerItem = LabelItem(title: menu.title)
        menuRows.append(MenuRowNode(size: rowSize, items: [headerItem], font: menu.configuration.titleFont))
        
        let rowCount = menu.items.count / 2
        for rowIdx in (0 ..< rowCount) {
            let firstItem = menu.items[rowIdx * 2]
            let secondItem = menu.items[rowIdx * 2 + 1]
            menuRows.append(MenuRowNode(size: rowSize, items: [firstItem, secondItem], font: menu.configuration.labelFont))
        }
        
        let tableHeight: CGFloat = CGFloat(1 + rowCount) * menu.configuration.rowHeight
        var y = (size.height - tableHeight) / 2
        let x = ((size.width - menu.configuration.menuWidth) / 2)
        for row in menuRows.reversed() {
            addChild(row)
            row.position = CGPoint(x: x, y: y)
            y += menu.configuration.rowHeight
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
        
    func handleInput(action: InputDeviceAction) {
        switch action {
        case _ where action.contains(.up):
            print("focus previous")
        case _ where action.contains(.down):
            print("focus next")
        default:
            break
        }
    }
}

#if os(macOS)

extension MenuScene {
    open override func mouseUp(with event: NSEvent) {
        let location = event.location(in: self)
        print("handle mouse click @ \(location)")
    }
    
    open override func keyUp(with event: NSEvent) {
        switch event.keyCode {
        case 126: handleInput(action: .up)
        case 125: handleInput(action: .down)
        case 123: handleInput(action: .left)
        case 124: handleInput(action: .right)
        case 49: handleInput(action: .triggerA)
        case 53: handleInput(action: .triggerB)
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
