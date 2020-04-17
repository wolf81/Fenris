//
//  MenuFooterNodeTests.swift
//  Tests
//
//  Created by Wolfgang Schreurs on 17/04/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import XCTest
import SpriteKit
@testable import Fenris

class MenuFooterNodeTests: XCTestCase {
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

    func testFocusNode() {
        let buttonItem = ButtonItem(title: "Test")
        let footerNode = MenuFooterNode(size: .zero, items: [buttonItem], font: self.font)
                
        XCTAssertTrue(footerNode.itemNodes.count == 1)
    }
}
