//
//  InputDeviceManagerTests.swift
//  Tests
//
//  Created by Wolfgang Schreurs on 21/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import XCTest
import SpriteKit
@testable import Fenris

class InputDeviceManagerTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSchemeChange() {
        let manager = InputDeviceManager()
        manager.scheme = .gamepad
        manager.onSchemeChange = { scheme in
            XCTAssert(scheme == .touch)
        }
        manager.scheme = .touch
    }
    
    func testDefaultSchemeForCurrentDevice() {
        let manager = InputDeviceManager()

        XCTAssert(manager.scheme == InputDeviceScheme.default && InputDeviceScheme.default == .mouseKeyboard)
    }
}
