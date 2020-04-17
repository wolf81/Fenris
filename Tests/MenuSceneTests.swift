//
//  MenuSceneTests.swift
//  Tests
//
//  Created by Wolfgang Schreurs on 17/04/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import XCTest
import SpriteKit
@testable import Fenris

class MenuSceneTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMenuScene() {
        let menuScene = MenuScene(size: .zero, configuration: TestMenuConfiguration(), menu: Menu(headerItems: [], listItems: [[]], footerItems: []))
        let view = SKView(frame: .zero)
        menuScene.didMove(to: view)
                
        XCTAssertTrue(menuScene.menuItemNodes.count == 0)
    }
    
    func testMenuSceneFocusNodeVisibilityForInputSchemes() {
        let buttonItem = ButtonItem(title: "Button")
        let viewFrame = CGRect(origin: .zero, size: CGSize(width: 800, height: 600))
        let menuScene = MenuScene(size: viewFrame.size, configuration: TestMenuConfiguration(), menu: Menu(headerItems: [], listItems: [[]], footerItems: [buttonItem]))
        menuScene.position = .zero
        let view = SKView(frame: viewFrame)
        menuScene.didMove(to: view)
                
        focusFirstMenuItemNodeInMenuScene(menuScene)
        
        (try! ServiceLocator.shared.get(service: InputDeviceManager.self)).scheme = .mouseKeyboard
        XCTAssertFalse(menuScene.focusNode.isHidden)
        
        (try! ServiceLocator.shared.get(service: InputDeviceManager.self)).scheme = .gamepad
        XCTAssertFalse(menuScene.focusNode.isHidden)

        (try! ServiceLocator.shared.get(service: InputDeviceManager.self)).scheme = .tvRemote
        XCTAssertFalse(menuScene.focusNode.isHidden)
        
        (try! ServiceLocator.shared.get(service: InputDeviceManager.self)).scheme = .touch
        XCTAssertTrue(menuScene.focusNode.isHidden)
    }
    
    func testMenuSceneKeyboardInput() {
        let buttonItem0 = ButtonItem(title: "Button 0")
        let buttonItem1 = ButtonItem(title: "Button 1")
        let buttonItem2 = ButtonItem(title: "Button 2")
        let viewFrame = CGRect(origin: .zero, size: CGSize(width: 800, height: 600))
        let menuScene = MenuScene(size: viewFrame.size, configuration: TestMenuConfiguration(), menu: Menu(headerItems: [], listItems: [[buttonItem0]], footerItems: [buttonItem1, buttonItem2]))
        menuScene.position = .zero
        let view = SKView(frame: viewFrame)
        menuScene.didMove(to: view)
                
        focusFirstMenuItemNodeInMenuScene(menuScene)
        XCTAssertTrue(menuScene.focusItemController.focusedItem!.interactableNode == menuScene.menuItemNodes[0]) // buttonItem0
        
        menuScene.handleKeyUp(action: .down)
        XCTAssertTrue(menuScene.focusItemController.focusedItem!.interactableNode == menuScene.menuItemNodes[1]) // buttonItem1 in footer

        menuScene.handleKeyUp(action: .right)
        XCTAssertTrue(menuScene.focusItemController.focusedItem!.interactableNode == menuScene.menuItemNodes[2]) // buttonItem2 in footer

        menuScene.handleKeyUp(action: .up)
        XCTAssertTrue(menuScene.focusItemController.focusedItem!.interactableNode == menuScene.menuItemNodes[0]) // buttonItem0
        
        menuScene.keyDown(with: NSEvent()) // doesn't do anything, but prevents the macOS beep
        XCTAssertTrue(menuScene.focusItemController.focusedItem!.interactableNode == menuScene.menuItemNodes[0]) // buttonItem0
    }
    
    // MARK: - Private
    
    private func focusFirstMenuItemNodeInMenuScene(_ menuScene: MenuScene) {
        // In order to test focus node visibility (node hidden or not), we first need to make sure an item is focused.
        // A focus node visibility is only changed if a focus node is set.
        let frame = menuScene.menuItemNodes.first!.calculateAccumulatedFrame()
        var position = menuScene.convert(frame.origin, from: menuScene.menuItemNodes.first!)
        position = CGPoint(x: position.x + frame.width / 2, y: position.y + frame.height / 2)
        menuScene.focusItemController.focusItem(at: position)
    }
    
    private class TestMenuConfiguration: MenuConfiguration {
        var menuWidth: CGFloat = 200
        
        var rowHeight: CGFloat = 20
        
        var titleFont: Font = Font(name: "Helvetica", size: 20)!
        
        var labelFont: Font = Font(name: "Helvetica", size: 10)!
    }
}
