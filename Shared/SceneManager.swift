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

/// The SceneManager can be used to transition between scenes with a built-in animation.
public class SceneManager: SceneManagerProtocol {
    public weak var viewController: SceneViewController?
    
    /// Designated initializer.
    ///
    /// - Parameter viewController: A view controller that conforms to ScenePresentable.
    public required init(viewController: SceneViewController) {
        self.viewController = viewController
    }
    
    /// Perform a transition using a built-in animation.
    ///
    /// - Parameters:
    ///   - scene: The scene to transition to.
    ///   - animation: The animation to use for the scene transition.
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
        
        self.viewController?.presentScene(scene: scene, transition: transition)
    }
}

/// The DummySceneManager is for internal use only and is used as a stand-in in the ServiceLocator
/// when no proper SceneManager is registered.
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
