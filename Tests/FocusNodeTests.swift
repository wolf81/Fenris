//
//  FocusNodeTests.swift
//  Tests
//
//  Created by Wolfgang Schreurs on 22/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import XCTest
import SpriteKit
@testable import Fenris

class FocusNodeTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFocusNode() {
        let strokeColor: SKColor = .yellow
        
        let focusNode = FocusNode(strokeColor: strokeColor)
        XCTAssertTrue(focusNode.strokeColor == strokeColor)
    }
}
