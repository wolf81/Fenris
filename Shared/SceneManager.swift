//
//  SceneManager.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 01/08/2018.
//  Copyright © 2018 Wolftrail. All rights reserved.
//

import Foundation
import SpriteKit

public protocol SceneManagerProtocol {

    /// The view controller that will be used by the scene manager.
    /// PLEASE NOTE: classes that implement this protocol should make
    /// this variable a weak reference to prevent retain cycles.
    var viewController: ScenePresentable? { get set }
    
    func transitionTo(scene: SKScene, animation: SceneTransitionAnimation)
}

public class SceneManager: SceneManagerProtocol {
    public weak var viewController: ScenePresentable?

    public init() {}
    
    public func transitionTo(scene: SKScene, animation: SceneTransitionAnimation) {
        var transition: SKTransition
        let duration = 0.5
        
        switch animation {
        case .fade:
            transition = SKTransition.fade(withDuration: duration)
        case .push:
            transition = SKTransition.push(with: SKTransitionDirection.left, duration: duration)
        case .pop:
            transition = SKTransition.push(with: SKTransitionDirection.right, duration: duration)
        }
        
        viewController?.presentScene(scene: scene, transition: transition)
    }
}

public class DummySceneManager: SceneManagerProtocol {
    public weak var viewController: ScenePresentable?
    
    public init() {}
    
    public func transitionTo(scene: SKScene, animation: SceneTransitionAnimation) {
        print("[DUMMY] transition to scene \(scene) with \(animation) animation")
    }
}
