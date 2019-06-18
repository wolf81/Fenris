//
//  MenuTests.swift
//  FenrisTests
//
//  Created by Wolfgang Schreurs on 18/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import XCTest
@testable import Fenris

class MenuTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMenu() {
        let menu = LabeledMenuBuilder()
            .withHeader(title: "Title")
            .withRow(title: "Row", item: NumberChooserItem(range: (0 ... 0), selectedValue: 0))
            .withFooter(items: [FixedSpaceItem(), FixedSpaceItem(), FixedSpaceItem()])
            .build()

        let headerLabel = menu.headerItems.first as! LabelItem
        XCTAssertTrue(headerLabel.title == "Title")
        XCTAssertTrue(menu.listItems.first?.count == 2)
        XCTAssertTrue(menu.listItems.first?[0] is LabelItem)
        XCTAssertTrue(menu.listItems.first?[1] is NumberChooserItem)
        XCTAssertTrue(menu.footerItems.count == 3)
    }
}
