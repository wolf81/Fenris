//
//  ScenePresentable.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 19/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

/// Scenes that conform to ScenePresentable are able to directly present other ScenePresentable
/// scenes and able to dismiss themselves, though only when the container view is of type SceneView.
public protocol ScenePresentable where Self: SKScene {
    
    /// Default constructor.
    ///
    /// - Parameter size: The size of the scene. Please note: it's up to the developer to make sure
    /// the proper state is restored here, when required.
    init(size: CGSize)
    
    /// Present another ScenePresentable scene.
    ///
    /// - Parameters:
    ///   - scene: A scene type.
    ///   - transition: A transition to use for presentation and dismissal.
    func present<T: ScenePresentable>(_ scene: T.Type, transition: SceneTransition)
    
    /// Dismiss this view, returning to the parent ScenePresentable view. Will not do anything if
    /// there is no parent. Please note: there is no real stack of views, instead views are
    /// recreated. It's up to the developer to make sure the scene restores it's proper state in
    /// the init(size:) constructor.
    func dismiss()
}

extension ScenePresentable {
    public func present<T: ScenePresentable>(_ scene: T.Type, transition: SceneTransition) {
        assert(self.view is SceneView, "present(_: transition:) is only usable for SceneView parent")
        (self.view as! SceneView).presentScene(scene, transition: transition)
    }
    
    public func dismiss() {
        assert(self.view is SceneView, "present(_: transition:) is only usable for SceneView parent")
        (self.view as! SceneView).dismissScene()
    }
}
