//
//  SceneManager.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 19/04/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import SpriteKit

public protocol SceneManagerConstructable: SKScene {
    init(size: CGSize, userInfo: [String: Any])
}

open class SceneManager: LocatableService {
    private unowned var view: SKView
    
    public init(view: SKView) {
        self.view = view
    }

    public func crossFade(to sceneType: SceneManagerConstructable.Type, duration: TimeInterval = 0.5, userInfo: [String: Any] = [:]) {
        let scene = sceneType.init(size: self.view.frame.size, userInfo: userInfo)
        self.view.presentScene(scene, transition: SKTransition.crossFade(withDuration: duration))
    }

    public func fade(to sceneType: SceneManagerConstructable.Type, duration: TimeInterval = 0.5, userInfo: [String: Any] = [:]) {
        let scene = sceneType.init(size: self.view.frame.size, userInfo: userInfo)
        self.view.presentScene(scene, transition: SKTransition.fade(withDuration: duration))
    }
    
    public func push(to sceneType: SceneManagerConstructable.Type, duration: TimeInterval = 0.5, userInfo: [String: Any] = [:]) {
        let scene = sceneType.init(size: self.view.frame.size, userInfo: userInfo)
        self.view.presentScene(scene, transition: SKTransition.push(with: .left, duration: duration))
    }

    public func pop(to sceneType: SceneManagerConstructable.Type, duration: TimeInterval = 0.5, userInfo: [String: Any] = [:]) {
        let scene = sceneType.init(size: self.view.frame.size, userInfo: userInfo)
        self.view.presentScene(scene, transition: SKTransition.push(with: .right, duration: duration))
    }
}
