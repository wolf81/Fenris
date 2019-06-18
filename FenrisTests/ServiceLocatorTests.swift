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
    private var serviceLocator: ServiceLocator!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()        
    }
    
    func testDummySceneManager() {
        let sceneManager = ServiceLocator().sceneManager
        
        XCTAssertTrue(sceneManager is DummySceneManager)
    }
    
    func testCustomSceneManager() {
        let serviceLocator = ServiceLocator()
        let viewController = CustomSceneViewController(nibName: nil, bundle: nil)
        let sceneManager = CustomSceneManager(viewController: viewController)
        
        XCTAssertTrue(serviceLocator.sceneManager is DummySceneManager)
        serviceLocator.provide(sceneManager: sceneManager)
        XCTAssertTrue(serviceLocator.sceneManager is CustomSceneManager)
    }
    
    private class CustomSceneViewController: ViewController & ScenePresentable {
        // For use in tests
    }
    
    private class CustomSceneManager: SceneManager {
        // For use in tests
    }
}
