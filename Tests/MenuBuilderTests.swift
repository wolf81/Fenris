//
//  MenuBuilderTests.swift
//  Tests
//
//  Created by Wolfgang Schreurs on 22/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import XCTest
@testable import Fenris

class MenuBuilderTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSimpleMenuBuilder() {
        let menu = SimpleMenuBuilder()
            .withEmptyRow()
            .withRow(item: ButtonItem(title: "Test"))
            .build()
        
        XCTAssertTrue(menu.headerItems.count == 0)
        XCTAssertTrue(menu.listItems.count == 2)
        XCTAssertTrue(menu.footerItems.count == 0)
    }
    
    func testLabeledMenuBuilder() {
        let menu = LabeledMenuBuilder()
            .withHeader(title: "Header")
            .withEmptyRow()
            .withRow(title: "Test", item: NumberChooserItem(range: 0 ... 5, selectedValue: 0))
            .withFooter(items: [ButtonItem(title: "FooterButton")])
            .build()
        
        XCTAssertTrue(menu.headerItems.count == 1)
        XCTAssertTrue(menu.listItems.count == 2)
        XCTAssertTrue(menu.footerItems.count == 1)
    }
}
