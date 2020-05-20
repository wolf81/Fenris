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
        let interactableNodes = self.testMenuScene.menuRowNodes.compactMap({ $0.itemNodes is [InputDeviceInteractable ]})
        XCTAssertTrue(self.focusItemController.itemCount == interactableNodes.count)
    }
    
    func testFocusAtLocation() {
        XCTAssertTrue(self.focusItemController.focusItem(at: CGPoint.zero))
        XCTAssertFalse(self.focusItemController.focusItem(at: CGPoint(x: 1, y: 1)))
        XCTAssertTrue(self.focusItemController.focusedItem == nil)
        
        let menuRowNode = self.testMenuScene.listRowNodes[0]
        let firstItemFrameCenter = CGPoint(x: menuRowNode.frame.midX, y: menuRowNode.frame.midY)
        
        XCTAssertTrue(self.focusItemController.focusItem(at: firstItemFrameCenter))
        XCTAssertTrue(self.focusItemController.focusedItem != nil)
    }
    
    func testFocusUp() {
        XCTAssertFalse(self.focusItemController.focusUp())
        XCTAssertTrue(self.testMenuScene.listRowNodes[0].intersects(self.focusItemController.focusedItem!.interactableNode))
        
        self.focusItemController.focusDown()
        XCTAssertTrue(self.focusItemController.focusUp())
    }

    func testFocusDown() {
        for i in (0 ..< self.testMenuScene.listRowNodes.count) {
            let expectedResult = i == self.testMenuScene.listRowNodes.count ? false : true
            XCTAssertTrue(self.testMenuScene.listRowNodes[i].intersects(self.focusItemController.focusedItem!.interactableNode))
            XCTAssertTrue(self.focusItemController.focusDown() == expectedResult)
        }

        XCTAssertFalse(self.focusItemController.focusDown())
    }
    
    func testFocusLeft() {
        XCTAssertFalse(self.focusItemController.focusLeft())
        XCTAssertTrue(self.testMenuScene.menuRowNodes[1].intersects(self.focusItemController.focusedItem!.interactableNode))
        
        for _ in (0 ..< self.testMenuScene.listRowNodes.count) {
            self.focusItemController.focusDown()
        }

        _ = self.focusItemController.focusRight()
        XCTAssertTrue(self.focusItemController.focusLeft())
    }
    
    func testFocusRight() {
        XCTAssertFalse(self.focusItemController.focusRight())
        XCTAssertTrue(self.testMenuScene.menuRowNodes[1].intersects(self.focusItemController.focusedItem!.interactableNode))
    }
    
    func testFocusChangeInvokesDelegate() {
        let expectation = XCTestExpectation(description: "focus change should notify delegate")
        
        self.focusItemControllerDelegate = TestDelegate(expectation: expectation)
        self.focusItemController.delegate = self.focusItemControllerDelegate
        self.focusItemController.focusDown()
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testEmptyMenuSceneNoFocus() {
        let testScene = SKScene(size: .zero)
        let focusItemController = FocusItemController(menuRowNodes: [],
                                                       parentNode: testScene)
        
        XCTAssertTrue(focusItemController.focusedItem == nil)
        XCTAssertFalse(focusItemController.focusUp())
        XCTAssertFalse(focusItemController.focusDown())
        XCTAssertFalse(focusItemController.focusLeft())
        XCTAssertFalse(focusItemController.focusRight())
        XCTAssertFalse(focusItemController.focusItem(at: .zero))
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
        var menuRowNodes: [MenuRowNode] {
            return [[self.headerNode], self.listRowNodes, [self.footerRowNode]].flatMap{ $0 }
        }
        
        let headerNode: MenuRowNode
        let listRowNodes: [MenuRowNode]
        let footerRowNode: MenuRowNode
        
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
            
            self.headerNode = MenuRowNode(size: rowSize, items: menu.headerItems, font: font, footerMinimumHorizontalSpacing: 5)
            
            var listRows: [MenuRowNode] = []
            for menuItemRow in menu.listItems {
                let menuRow = MenuRowNode(size: rowSize, items: menuItemRow, font: font, footerMinimumHorizontalSpacing: 5)
                listRows.append(menuRow)
            }
            self.listRowNodes = listRows
            
            self.footerRowNode = MenuRowNode(size: rowSize, items: menu.footerItems, font: font, footerMinimumHorizontalSpacing: 5)
            
            super.init(size: size)

            let menuHeight = self.menuRowNodes.reduce(0) { $0 + $1.frame.size.height }
            var y = (size.height - menuHeight) / 2
            let x = ((size.width - menuWidth) / 2)
            for row in self.menuRowNodes.reversed() {
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
