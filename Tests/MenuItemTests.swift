//
//  FenrisTests.swift
//  FenrisTests
//
//  Created by Wolfgang Schreurs on 01/08/2018.
//  Copyright © 2018 Wolftrail. All rights reserved.
//

import XCTest
import SpriteKit
@testable import Fenris

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
    
    // MARK: - FixedSpace
    
    func testFixedSpaceNode() {
        let fixedSpaceItem = FixedSpaceItem()
        let node = fixedSpaceItem.getNode(size: .zero, font: self.font)
        
        XCTAssertTrue(node is FixedSpaceNode)
    }
    
    // MARK: - LabelItem
    
    func testLabelNode() {
        let labelItem = LabelItem(title: "Title")
        let node = labelItem.getNode(size: .zero, font: self.font)
        
        XCTAssertTrue(node is LabelNode)
    }
    
    func testLabelItemTitle() {
        let labelItem = LabelItem(title: "Title")
        
        XCTAssertTrue(labelItem.title == "Title")
    }
    
    // MARK: - ButtonItem
    
    func testButtonItemNode() {
        let button = ButtonItem(title: "Title", onClick: {})
        let node = button.getNode(size: .zero, font: self.font)
        
        XCTAssertTrue(node is ButtonNode)
    }
    
    func testButtonItemTitle() {
        let button = ButtonItem(title: "Title", onClick: {})
        
        XCTAssertTrue(button.title == "Title")
    }
    
    func testButtonItemClickHandler() {
        let expectation = XCTestExpectation(description: "Receive button click")
        let button = ButtonItem(title: "Test") { expectation.fulfill() }
        
        button.onClick?()        
        wait(for: [expectation], timeout: 1)
    }
    
    // MARK: - NumberChooserItem
    
    func testNumberChooserItemRangeChange() {
        let numberChooser = NumberChooserItem(range: (1 ... 1), selectedValue: 10)
        XCTAssert(numberChooser.range.count == 1)
        XCTAssert(numberChooser.selectedValue == 1)
        
        numberChooser.range = (2 ... 8)
    }
    
    func testNumberChooserSelectedIndexInBoundsOnValuesChange() {
        let numberChooser = NumberChooserItem(range: (0 ... 5), selectedValue: 4)
        XCTAssert(numberChooser.selectedValue == 4)

        numberChooser.range = (6 ... 10)
        XCTAssert(numberChooser.selectedValue == 6)
    }
    
    func testNumberChooserNode() {
        let numberChooser = NumberChooserItem(range: (0 ... 0), selectedValue: 0)
        let node = numberChooser.getNode(size: .zero, font: self.font)
        
        XCTAssertTrue(node is NumberChooserNode)
    }
    
    func testEmptyNumberChooserItemOutOfRange() {
        let numberChooser = NumberChooserItem(range: (0 ... 0), selectedValue: 0)
        let node = numberChooser.getNode(size: .zero, font: self.font)
        
        XCTAssertTrue((node as! NumberChooserNode).text == "0")
    }

    func testNumberChooserItemValueChangeValidateTrue() {
        let numberChooser = NumberChooserItem(range: (0 ... 3), selectedValue: 1)
        numberChooser.onValidate = { selectedIdx in return true }

        XCTAssertTrue(numberChooser.selectedValue == 1)
        numberChooser.selectedValue = 0
        XCTAssertTrue(numberChooser.selectedValue == 0)
    }

    func testNumberChooserItemValueChangeValidateFalse() {
        let numberChooser = NumberChooserItem(range: (0 ... 3), selectedValue: 1)
        numberChooser.onValidate = { selectedIdx in return false }

        XCTAssertTrue(numberChooser.selectedValue == 1)
        numberChooser.selectedValue = 0
        XCTAssertTrue(numberChooser.selectedValue == 1)
    }
    
    // MARK: - TextChooserItem
    
    func testTextChooserItemRangeChange() {
        let textChooser = TextChooserItem(values: [], selectedValueIdx: 0)
        XCTAssert(textChooser.values.count == 0)
        
        let values = ["a", "b", "c"]
        textChooser.values = values
        XCTAssert(textChooser.values == values)
    }
    
    func testTextChooserSelectedIndexInBoundsOnValuesChange() {
        let textChooser = TextChooserItem(values: ["a", "b", "c"], selectedValueIdx: 4)
        XCTAssert(textChooser.selectedValueIdx == 2)
        
        textChooser.values = ["a", "b"]
        XCTAssert(textChooser.selectedValueIdx == 1)
    }
    
    func testTextChooserItemNode() {
        let textChooser = TextChooserItem(values: [], selectedValueIdx: 0)
        let node = textChooser.getNode(size: .zero, font: self.font)
        
        XCTAssertTrue(node is TextChooserNode)
    }
    
    func testEmptyTextChooserItemOutOfRange() {
        let textChooser = TextChooserItem(values: [], selectedValueIdx: 0)
        let node = textChooser.getNode(size: .zero, font: self.font)
        
        XCTAssertTrue((node as! TextChooserNode).text == nil)
    }

    func testTextChooserItemValueChangeValidateTrue() {
        let textChooser = TextChooserItem(values: ["Apple", "Banana", "Citrus"], selectedValueIdx: 1)
        textChooser.onValidate = { selectedIdx in return true }

        XCTAssertTrue(textChooser.values[textChooser.selectedValueIdx] == "Banana")
        textChooser.selectedValueIdx = 0
        XCTAssertTrue(textChooser.values[textChooser.selectedValueIdx] == "Apple")
    }

    func testTextChooserItemValueChangeValidateFalse() {
        let textChooser = TextChooserItem(values: ["Apple", "Banana", "Citrus"], selectedValueIdx: 2)
        textChooser.onValidate = { selectedIdx in return false }

        XCTAssertTrue(textChooser.values[textChooser.selectedValueIdx] == "Citrus")
        textChooser.selectedValueIdx = 1
        XCTAssertTrue(textChooser.values[textChooser.selectedValueIdx] == "Citrus")
    }
    
    // MARK: - ToggleItem
    
    func testToggleItemNode() {
        let toggle = ToggleItem(enabled: true)
        let node = toggle.getNode(size: .zero, font: self.font)
        
        XCTAssertTrue(node is ToggleNode)
    }
    
    func testToggleItemTitle() {
        let toggle = ToggleItem(enabled: true)
        let node = toggle.getNode(size: .zero, font: self.font)
        
        XCTAssertTrue((node as! ToggleNode).text == "On")
        toggle.isEnabled = false
        XCTAssertTrue((node as! ToggleNode).text == "Off")
    }
    
    func testToggleItemValueChangeValidateFalse() {
        let toggle = ToggleItem(enabled: true)
        toggle.onValidate = { enabled in return false }

        XCTAssertTrue(toggle.isEnabled == true)
        toggle.isEnabled = false
        XCTAssertTrue(toggle.isEnabled == true)
    }
    
    func testToggleItemValueChangeValidateTrue() {
        let toggle = ToggleItem(enabled: true)
        toggle.onValidate = { enabled in return true }

        XCTAssertTrue(toggle.isEnabled == true)
        toggle.isEnabled = false
        XCTAssertTrue(toggle.isEnabled == false)
    }
}
