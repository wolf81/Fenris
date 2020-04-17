//
//  MenuConfigurationTests.swift
//  Tests
//
//  Created by Wolfgang Schreurs on 17/04/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import XCTest
import SpriteKit
@testable import Fenris

class MenuConfigurationTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testMenuConfiguration() {
        let configuration = TestMenuConfiguration()
        
        XCTAssertTrue(configuration.focusRectColor == SKColor.yellow)
    }
    
    private class TestMenuConfiguration: MenuConfiguration {
        var menuWidth: CGFloat = 200
        
        var rowHeight: CGFloat = 20
        
        var titleFont: Font = Font(name: "Helvetica", size: 20)!
        
        var labelFont: Font = Font(name: "Helvetica", size: 10)!
    }
}
