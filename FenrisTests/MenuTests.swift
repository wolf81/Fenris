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
        let menu = Menu(
            title: nil,
            items: [
                FixedSpaceItem(),
            ],
            footerItems: [],
            configuration: MenuBuilder.Configuration(menuWidth: 0, rowHeight: 0, titleFont: Font(name: "Papyrus", size: 12)!, labelFont: Font(name: "Papyrus", size: 10)!)
        )
    }
}
