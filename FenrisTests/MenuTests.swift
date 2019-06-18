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
        let configuration = MenuBuilder.Configuration(
            menuWidth: 0,
            rowHeight: 0,
            titleFont: Font(name: "Papyrus", size: 12)!,
            labelFont: Font(name: "Papyrus", size: 10)!
        )

        let builder = MenuBuilder(configuration: configuration)
            .withHeader(title: "Title")
            .withRow(title: "Row", item: NumberChooserItem(range: (0 ... 0), selectedValue: 0))
            .withFooter(items: [FixedSpaceItem(), FixedSpaceItem(), FixedSpaceItem()])
        
        let menu = builder.build()
        XCTAssertTrue(menu.title == "Title")
        XCTAssertTrue(menu.items.count == 2)
        XCTAssertTrue(menu.items[0] is LabelItem)
        XCTAssertTrue(menu.items[1] is NumberChooserItem)
        XCTAssertTrue(menu.footerItems.count == 3)
    }
}
