//
//  FontTests.swift
//  FenrisTests
//
//  Created by Wolfgang Schreurs on 18/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import XCTest
@testable import Fenris

class FontTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testValidFont() {
        let font = Font(name: "Helvetica", size: 12)
        XCTAssertTrue(font != nil)
    }
    
    func testInvalidFont() {
        let font = Font(name: "NonExistingFont", size: 12)
        XCTAssertTrue(font == nil)
    }
}
