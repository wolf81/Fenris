//
//  SceneManager.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 01/08/2018.
//  Copyright © 2018 Wolftrail. All rights reserved.
//

import Foundation
import SpriteKit

public typealias SceneViewController = (ViewController & ScenePresentable)

public protocol SceneManagerProtocol: class {
    
    /// The view controller that will be used by the scene manager.
    /// PLEASE NOTE: classes that implement this protocol should make
    /// this variable a weak reference to prevent retain cycles.
    var viewController: SceneViewController? { get set }
    
    init(viewController: SceneViewController)
    
    func transitionTo(scene: SKScene, animation: SceneTransitionAnimation)
}

public class SceneManager: SceneManagerProtocol {
    public weak var viewController: SceneViewController?
    
    public required init(viewController: SceneViewController) {
        self.viewController = viewController
    }
    
    public func transitionTo(scene: SKScene, animation: SceneTransitionAnimation) {        
        var transition: SKTransition
        let duration = 0.5
        
        switch animation {
        case .fade:
            transition = .fade(withDuration: duration)
        case .push:
            transition = .push(with: .left, duration: duration)
        case .pop:
            transition = .push(with: .right, duration: duration)
        }
        
        viewController?.presentScene(scene: scene, transition: transition)
    }
}

internal class DummySceneManager: SceneManagerProtocol {
    weak var viewController: SceneViewController?

    required init(viewController: SceneViewController) {
        self.viewController = viewController
    }    
    
    public init() {}
    
    public func transitionTo(scene: SKScene, animation: SceneTransitionAnimation) {
        print("[DUMMY] transition to scene \(type(of: scene)) with \(animation) animation")
    }
}
