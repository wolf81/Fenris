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
    
    // MARK: - ToggleNode
    
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
    
    // MARK: - TextChooserNode
    
    func testTextChooserNodeMouseClick() {
        let nodeSize = CGSize(width: 100, height: 20)
        let textChooserItem = TextChooserItem(values: ["A", "B", "C"], selectedValueIdx: 1)
        let node = textChooserItem.getNode(size: nodeSize, font: self.font) as! TextChooserNode
        
        // TODO: These clicks are a bit "hacky", but basically we're testing the following:
        // - taps in the center (label) shouldn't change the selected value
        // - taps in the left arrow button should decrease the selected value
        // - taps in the right arrow button should increase the selected value
        // Figure out how to improve the test, perhaps by exposing button frames?
        
        node.handleMouseUp(location: CGPoint(x: nodeSize.width / 2, y: nodeSize.height / 2))
        XCTAssert(textChooserItem.selectedValueIdx == 1)
        
        node.handleMouseUp(location: CGPoint(x: 0, y: nodeSize.height / 2))
        XCTAssert(textChooserItem.selectedValueIdx == 0)

        node.handleMouseUp(location: CGPoint(x: nodeSize.width - 1, y: nodeSize.height / 2))
        XCTAssert(textChooserItem.selectedValueIdx == 1)
    }
    
    func testTextChooserNodeKeyboardButtonClick() {
        let textChooserItem = TextChooserItem(values: ["A", "B", "C"], selectedValueIdx: 0)
        let node = textChooserItem.getNode(size: .zero, font: self.font) as! TextChooserNode

        node.handleKeyUp(action: .action1)
        XCTAssert(textChooserItem.selectedValueIdx == 0)
        
        node.handleKeyUp(action: .left)
        XCTAssert(textChooserItem.selectedValueIdx == 2)

        node.handleKeyUp(action: .right)
        XCTAssert(textChooserItem.selectedValueIdx == 0)
    }
    
    func testTextChooserNodeGamepadButtonClick() {
        let textChooserItem = TextChooserItem(values: ["A", "B", "C"], selectedValueIdx: 0)
        let node = textChooserItem.getNode(size: .zero, font: self.font) as! TextChooserNode

        node.handleInput(action: .buttonA)
        XCTAssert(textChooserItem.selectedValueIdx == 0)

        node.handleInput(action: .left)
        XCTAssert(textChooserItem.selectedValueIdx == 2)

        node.handleInput(action: .right)
        XCTAssert(textChooserItem.selectedValueIdx == 0)
    }

    // MARK: - NumberChooserNode

    func testNumberChooserNodeMouseClick() {
        let nodeSize = CGSize(width: 100, height: 20)
        let numberChooserItem = NumberChooserItem(range: 0 ... 3, selectedValue: 1)
        let node = numberChooserItem.getNode(size: nodeSize, font: self.font) as! NumberChooserNode

        // TODO: These clicks are a bit "hacky", but basically we're testing the following:
        // - taps in the center (label) shouldn't change the selected value
        // - taps in the left arrow button should decrease the selected value
        // - taps in the right arrow button should increase the selected value
        // Figure out how to improve the test, perhaps by exposing button frames?
        
        node.handleMouseUp(location: CGPoint(x: nodeSize.width / 2, y: nodeSize.height / 2))
        XCTAssert(numberChooserItem.selectedValue == 1)
        
        node.handleMouseUp(location: CGPoint(x: 0, y: nodeSize.height / 2))
        XCTAssert(numberChooserItem.selectedValue == 0)
        
        node.handleMouseUp(location: CGPoint(x: nodeSize.width - 1, y: nodeSize.height / 2))
        XCTAssert(numberChooserItem.selectedValue == 1)
    }
    
    func testNumberChooserNodeKeyboardButtonClick() {
        let numberChooserItem = NumberChooserItem(range: 0 ... 1, selectedValue: 0)
        let node = numberChooserItem.getNode(size: .zero, font: self.font) as! NumberChooserNode

        node.handleKeyUp(action: .action1)
        XCTAssert(numberChooserItem.selectedValue == 0)
        
        node.handleKeyUp(action: .left)
        XCTAssert(numberChooserItem.selectedValue == 0)
        
        node.handleKeyUp(action: .right)
        XCTAssert(numberChooserItem.selectedValue == 1)

        node.handleKeyUp(action: .right)
        XCTAssert(numberChooserItem.selectedValue == 1)
    }
    
    func testNumberChooserNodeGamepadButtonClick() {
        let numberChooserItem = NumberChooserItem(range: 0 ... 1, selectedValue: 1)
        let node = numberChooserItem.getNode(size: .zero, font: self.font) as! NumberChooserNode

        node.handleInput(action: .buttonA)
        XCTAssert(numberChooserItem.selectedValue == 1)
        
        node.handleInput(action: .left)
        XCTAssert(numberChooserItem.selectedValue == 0)
        
        node.handleInput(action: .right)
        XCTAssert(numberChooserItem.selectedValue == 1)
    }
    
    // MARK: - ButtonNode

    func testButtonNodeMouseClick() {
        let expectation = XCTestExpectation(description: "Receive button click")
        let button = ButtonItem(title: "Test") { expectation.fulfill() }
        let node = button.getNode(size: .zero, font: self.font) as! ButtonNode
        node.handleMouseUp(location: .zero)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testButtonNodeGamepadButtonClick() {
        let expectation = XCTestExpectation(description: "Receive button click")
        let button = ButtonItem(title: "Test") { expectation.fulfill() }
        let node = button.getNode(size: .zero, font: self.font) as! ButtonNode
        node.handleInput(action: .buttonA)
        
        wait(for: [expectation], timeout: 1)
    }

    func testButtonNodeKeyboardButtonClick() {
        let expectation = XCTestExpectation(description: "Receive button click")
        let button = ButtonItem(title: "Test") { expectation.fulfill() }
        let node = button.getNode(size: .zero, font: self.font) as! ButtonNode
        node.handleKeyUp(action: .action1)
        
        wait(for: [expectation], timeout: 1)
    }
}
