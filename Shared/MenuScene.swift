//
//  MenuScene.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 01/08/2018.
//  Copyright © 2018 Wolftrail. All rights reserved.
//

import SpriteKit

open class MenuScene: SKScene {
    private var menuContainer: MenuContainerNode
    
    public init(size: CGSize, configuration: MenuConfiguration, items: [MenuItem]) {
        var itemNodes: [MenuItemContainerNode] = []
        items.forEach { (item) in
            itemNodes.append(MenuItemContainerNode(menuItem: item, configuration: configuration))
        }
        
        self.menuContainer = MenuContainerNode(width: configuration.menuWidth, nodeHeight: configuration.itemHeight, nodes: itemNodes)
        super.init(size: size)
        
        self.scaleMode = .aspectFit

        addChild(self.menuContainer)
        let y = (self.frame.height - self.menuContainer.frame.height) / 2
        self.menuContainer.position = CGPoint(x: (self.frame.width - self.menuContainer.frame.width) / 2, y: y)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

extension MenuScene: SceneInteractable {
    func action() {
        
    }
    
    func up() {
        self.menuContainer.up()
    }
    
    func down() {
        self.menuContainer.down()
    }
    
    func left() {
        self.menuContainer.left()
    }
    
    func right() {
        self.menuContainer.right()
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
        case 126: self.up()
        case 125: self.down()
        case 123: self.left()
        case 124: self.right()
        case 49: self.action()
        case 53: print("escape")
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
