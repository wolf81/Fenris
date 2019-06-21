//
//  FunctionsTests.swift
//  Tests
//
//  Created by Wolfgang Schreurs on 21/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import XCTest
@testable import Fenris

class FunctionsTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitializeInputDeviceManagerIfNeeded() {
        var manager = try? ServiceLocator.shared.get(service: InputDeviceManager.self)
        XCTAssert(manager == nil)

        let scene = InputDeviceInteractableScene(size: .zero)
        initializeInputDeviceManagerIfNeeded(scene: scene,
                                             onInputDeviceChanged: nil)
        
        manager = try? ServiceLocator.shared.get(service: InputDeviceManager.self)
        XCTAssert(manager != nil)
    }
}
