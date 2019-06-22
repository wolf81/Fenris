//
//  MenuItemNodeTests.swift
//  Tests
//
//  Created by Wolfgang Schreurs on 22/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import XCTest
@testable import Fenris

class MenuItemNodeTests: XCTestCase {
    private var font: Font!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.font = Font(name: "Helvetica", size: 12)!
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testToggleNodeMouseClick() {
        let toggleItem = ToggleItem(enabled: true)
        let node = toggleItem.getNode(size: .zero, font: self.font) as! ToggleNode
        
        node.handleMouseUp(location: CGPoint(x: 10, y: 10))
        XCTAssert(toggleItem.isEnabled == true)
        
        node.handleMouseUp(location: .zero)
        XCTAssert(toggleItem.isEnabled == false)
    }

    func testToggleNodeGamepadButtonClick() {
        let toggleItem = ToggleItem(enabled: true)
        let node = toggleItem.getNode(size: .zero, font: self.font) as! ToggleNode
        
        node.handleInput(action: .buttonA)
        XCTAssert(toggleItem.isEnabled == true)
        
        node.handleInput(action: .left)
        XCTAssert(toggleItem.isEnabled == false)

        node.handleInput(action: .right)
        XCTAssert(toggleItem.isEnabled == true)
    }

    func testToggleNodeKeyboardButtonClick() {
        let toggleItem = ToggleItem(enabled: true)
        let node = toggleItem.getNode(size: .zero, font: self.font) as! ToggleNode
        
        node.handleKeyUp(action: .action1)
        XCTAssert(toggleItem.isEnabled == true)

        node.handleKeyUp(action: .left)
        XCTAssert(toggleItem.isEnabled == false)

        node.handleKeyUp(action: .right)
        XCTAssert(toggleItem.isEnabled == true)
    }
}
