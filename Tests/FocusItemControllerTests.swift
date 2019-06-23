//
//  FocusItemControllerTests.swift
//  Tests
//
//  Created by Wolfgang Schreurs on 23/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import XCTest
import SpriteKit
@testable import Fenris

class FocusItemControllerTests: XCTestCase {
    private var focusItemController: FocusItemController!
    private var testMenuScene: TestMenuScene!
    private var focusItemControllerDelegate: FocusItemControllerDelegate?

    override func setUp() {
        super.setUp()
        
        self.testMenuScene = TestMenuScene(size: CGSize(width: 640, height: 480))
        self.focusItemController = FocusItemController(menuRowNodes: self.testMenuScene.menuRowNodes,
                                                       parentNode: self.testMenuScene)
    }
    
    override func tearDown() {
        super.tearDown()
        
        self.testMenuScene = nil
        self.focusItemController = nil
        self.focusItemControllerDelegate = nil
    }
    
    func testItemCount() {
        XCTAssert(self.focusItemController.itemCount == 5)
    }
    
    func testFocusAtLocation() {
        self.focusItemController.focusItem(at: CGPoint(x: 1, y: 1))
        XCTAssert(self.focusItemController.focusedItem == nil)
    }
    
    func testFocusUp() {
        let didChangeFocus = self.focusItemController.focusUp()
        self.testMenuScene.menuRowNodes.forEach({ print($0.frame) })
        XCTAssert(didChangeFocus == false)
        XCTAssert(self.testMenuScene.menuRowNodes[1].intersects(self.focusItemController.focusedItem!.interactableNode))
    }

    func testFocusDown() {
        let didChangeFocus = self.focusItemController.focusDown()
        self.testMenuScene.menuRowNodes.forEach({ print($0.frame) })
        XCTAssert(didChangeFocus == true)
        XCTAssert(self.testMenuScene.menuRowNodes[2].intersects(self.focusItemController.focusedItem!.interactableNode))
    }
    
    func testFocusLeft() {
        var didChangeFocus = self.focusItemController.focusLeft()
        self.testMenuScene.menuRowNodes.forEach({ print($0.frame) })
        XCTAssert(didChangeFocus == false)
        XCTAssert(self.testMenuScene.menuRowNodes[1].intersects(self.focusItemController.focusedItem!.interactableNode))
        
        self.focusItemController.focusDown()
        self.focusItemController.focusDown()
        self.focusItemController.focusDown()
        _ = self.focusItemController.focusRight()
        didChangeFocus = self.focusItemController.focusLeft()
        XCTAssert(didChangeFocus == true)
    }
    
    func testFocusRight() {
        let didChangeFocus = self.focusItemController.focusLeft()
        self.testMenuScene.menuRowNodes.forEach({ print($0.frame) })
        XCTAssert(didChangeFocus == false)
        XCTAssert(self.testMenuScene.menuRowNodes[1].intersects(self.focusItemController.focusedItem!.interactableNode))
    }
    
    func testFocusChangeInvokesDelegate() {
        let expectation = XCTestExpectation(description: "focus change should notify delegate")
        
        self.focusItemControllerDelegate = TestDelegate(expectation: expectation)
        self.focusItemController.delegate = self.focusItemControllerDelegate
        self.focusItemController.focusDown()
        
        wait(for: [expectation], timeout: 1)
    }
    
    private class TestDelegate: FocusItemControllerDelegate {
        private var expectation: XCTestExpectation
        
        init(expectation: XCTestExpectation) {
            self.expectation = expectation
        }
        
        func focusItemController(_ controller: FocusItemController, didChangeFocusedItem focusItem: FocusItem?) {
            expectation.fulfill()
        }
    }
    
    private class TestMenuScene: SKScene {
        let menuRowNodes: [MenuRowNode]
        
        override init(size: CGSize) {
            let menu = LabeledMenuBuilder()
                .withHeader(title: "Test Header")
                .withRow(title: "Label 1", item: ToggleItem(enabled: false))
                .withRow(title: "Label 2", item: ToggleItem(enabled: false))
                .withRow(title: "Label 3", item: ToggleItem(enabled: false))
                .withFooter(items: [ButtonItem(title: "Button 1"), ButtonItem(title: "Button 2")])
                .build()
            
            let font = Font(name: "Helvetica", size: 12)!
            let menuWidth: CGFloat = 100
            let rowSize = CGSize(width: menuWidth, height: 30)
            var menuRows: [MenuRowNode] = []
            
            let headerRow = MenuRowNode(size: rowSize, items: menu.headerItems, font: font)
            menuRows.append(headerRow)
            
            for menuItemRow in menu.listItems {
                let menuRow = MenuRowNode(size: rowSize, items: menuItemRow, font: font)
                menuRows.append(menuRow)
            }
            
            let footerRow = MenuRowNode(size: rowSize, items: menu.footerItems, font: font)
            menuRows.append(footerRow)
            
            self.menuRowNodes = menuRows.reversed()
            
            super.init(size: size)

            let menuHeight = menuRows.reduce(0) { $0 + $1.frame.size.height }
            var y = (size.height - menuHeight) / 2
            let x = ((size.width - menuWidth) / 2)
            for row in menuRows.reversed() {
                addChild(row)
                row.position = CGPoint(x: x, y: y)
                y += row.frame.size.height
            }
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError()
        }
    }
}
