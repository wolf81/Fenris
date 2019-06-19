//
//  ServiceLocatorTests.swift
//  FenrisTests
//
//  Created by Wolfgang Schreurs on 18/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import XCTest
import SpriteKit
@testable import Fenris

class ServiceLocatorTests: XCTestCase {
    override func setUp() {
        super.setUp()
        
        _ = ServiceLocator.shared.remove(service: AdditionService.self)
    }
    
    override func tearDown() {
        super.tearDown()        
    }
    
    func testAddService() {
        try! ServiceLocator.shared.add(service: AdditionService())
        let service = try! ServiceLocator.shared.get(service: AdditionService.self)
        let result = service.add(x: 1, y: 1)
        
        XCTAssertTrue(result == 2)
    }
    
    func testRemoveExistingService() {
        try! ServiceLocator.shared.add(service: AdditionService())
        let didRemove = ServiceLocator.shared.remove(service: AdditionService.self)
        
        XCTAssertTrue(didRemove == true)
    }
    
    func testRemoveNonExistingService() {
        let didRemove = ServiceLocator.shared.remove(service: AdditionService.self)
        
        XCTAssertTrue(didRemove == false)
    }
    
    func testServiceAlreadyAddedError() {
        try! ServiceLocator.shared.add(service: AdditionService())
        
        XCTAssertThrowsError(try ServiceLocator.shared.add(service: AdditionService()))
    }
    
    func testServiceNotAddedError() {
        XCTAssertThrowsError(try ServiceLocator.shared.get(service: AdditionService.self))
    }
    
    private class AdditionService: LocatableService {
        func add(x: Int, y: Int) -> Int { return x + y }
    }
}
