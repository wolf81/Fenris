//
//  FenrisTests.swift
//  FenrisTests
//
//  Created by Wolfgang Schreurs on 01/08/2018.
//  Copyright © 2018 Wolftrail. All rights reserved.
//

import XCTest
@testable import Fenris
import SpriteKit

class MenuItemTests: XCTestCase {
    private var font: Font!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.font = Font(name: "Helvetica", size: 12)!
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - LabelItem
    
    func testLabelItemTitle() {
        let labelItem = LabelItem(title: "Title")
        
        XCTAssertTrue(labelItem.title == "Title")
    }
    
    // MARK: - ButtonItem
    
    func testButtonItemTitle() {
        let button = ButtonItem(title: "Title", onClick: {})
        
        XCTAssertTrue(button.title == "Title")
    }
    
    func testButtonItemClickHandler() {
        let expectation = XCTestExpectation(description: "Receive button click")
        
        let button = ButtonItem(title: "Test") {
            expectation.fulfill()
        }
        
        button.onClick()
    }
    
    // MARK: - NumberChooserItem
    
    func testEmptyNumberChooserOutOfRange() {
        let numberChooser = NumberChooserItem(range: (0 ... 0), selectedValue: 0)
        let menuItemNode = numberChooser.getNode(size: .zero, font: self.font)
        
        XCTAssertTrue(menuItemNode is NumberChooserNode)
        XCTAssertTrue((menuItemNode as! NumberChooserNode).text == "0")
    }

    func testNumberChooserValueChangeValidateTrue() {
        let numberChooser = NumberChooserItem(range: (0 ... 3), selectedValue: 1)

        XCTAssertTrue(numberChooser.selectedValue == 1)
        numberChooser.onValidate = { selectedIdx in return true }
        numberChooser.selectedValue = 0
        XCTAssertTrue(numberChooser.selectedValue == 0)
    }

    func testNumberChooserValueChangeValidateFalse() {
        let numberChooser = NumberChooserItem(range: (0 ... 3), selectedValue: 1)
        
        XCTAssertTrue(numberChooser.selectedValue == 1)
        numberChooser.onValidate = { selectedIdx in return false }
        numberChooser.selectedValue = 0
        XCTAssertTrue(numberChooser.selectedValue == 1)
    }
    
    // MARK: - TextChooserItem
    
    func testEmptyTextChooserOutOfRange() {
        let textChooser = TextChooserItem(values: [], selectedValueIdx: 0)
        let menuItemNode = textChooser.getNode(size: .zero, font: self.font)
        
        XCTAssertTrue(menuItemNode is TextChooserNode)
        XCTAssertTrue((menuItemNode as! TextChooserNode).text == nil)
    }

    func testTextChooserValueChangeValidateTrue() {
        let textChooser = TextChooserItem(values: ["Apple", "Banana", "Citrus"], selectedValueIdx: 1)
        XCTAssertTrue(textChooser.values[textChooser.selectedValueIdx] == "Banana")
        textChooser.onValidate = { selectedIdx in return true }
        textChooser.selectedValueIdx = 0
        XCTAssertTrue(textChooser.values[textChooser.selectedValueIdx] == "Apple")
    }

    func testTextChooserValueChangeValidateFalse() {
        let textChooser = TextChooserItem(values: ["Apple", "Banana", "Citrus"], selectedValueIdx: 2)
        XCTAssertTrue(textChooser.values[textChooser.selectedValueIdx] == "Citrus")
        textChooser.onValidate = { selectedIdx in return false }
        textChooser.selectedValueIdx = 1
        XCTAssertTrue(textChooser.values[textChooser.selectedValueIdx] == "Citrus")
    }
    
    // MARK: - ToggleItem
    
    func testToggleItemTitle() {
        let toggle = ToggleItem(enabled: true)
        let menuItemNode = toggle.getNode(size: .zero, font: self.font)
        
        XCTAssertTrue(menuItemNode is ToggleNode)
        XCTAssertTrue((menuItemNode as! ToggleNode).text == "On")

        toggle.isEnabled = false
        
        XCTAssertTrue((menuItemNode as! ToggleNode).text == "Off")
    }
}
