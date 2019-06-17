//
//  FenrisTests.swift
//  FenrisTests
//
//  Created by Wolfgang Schreurs on 01/08/2018.
//  Copyright © 2018 Wolftrail. All rights reserved.
//

import XCTest
@testable import Fenris

class FenrisTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEmptyTextChooser() {
        let textChooser = TextChooserItem(values: [], selectedValueIdx: 1)
        let menuItemNode = textChooser.getNode(size: CGSize.zero, font: Font(name: "Helvetica", size: 12)!)

        XCTAssertTrue(menuItemNode is TextChooserNode)
        XCTAssertTrue((menuItemNode as! TextChooserNode).text == nil)        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
