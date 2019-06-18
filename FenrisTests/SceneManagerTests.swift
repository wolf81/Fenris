//
//  SceneManagerTests.swift
//  FenrisTests
//
//  Created by Wolfgang Schreurs on 18/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import XCTest
import SpriteKit
@testable import Fenris

class SceneManagerTests: XCTestCase {
    var sceneViewController: TestingSceneViewController!

    override func setUp() {
        super.setUp()
        
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: Bundle(for: type(of: self)))
        self.sceneViewController = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("ViewController")) as? TestingSceneViewController
        
        _ = self.sceneViewController.view
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSceneManager() {
        let sceneManager = TestingSceneManager(viewController: self.sceneViewController)
        
        let newScene = SKScene(size: .zero)
        sceneManager.transitionTo(scene: newScene, animation: .pop)
        
        XCTAssertTrue(self.sceneViewController.skView.scene == newScene)
    }    
}
