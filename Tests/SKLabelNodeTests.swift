//
//  SKLabelNodeTests.swift
//  Tests
//
//  Created by Wolfgang Schreurs on 21/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import XCTest
import SpriteKit
@testable import Fenris

class SKLabelNodeTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLabelFontChange() {
        let fontName = "Helvetica"
        let fontSize = CGFloat(12)
        let font = Font(name: fontName, size: fontSize)
        
        let label = SKLabelNode()
        XCTAssert(label.fontName != fontName && label.fontSize != fontSize)
        
        label.font = font
        XCTAssert(label.fontName == fontName && label.fontSize == fontSize)
    }
}
