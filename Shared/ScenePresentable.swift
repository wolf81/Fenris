//
//  ScenePresentable.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 01/08/2018.
//  Copyright © 2018 Wolftrail. All rights reserved.
//

import Foundation
import SpriteKit

public protocol ScenePresentable where Self: ViewController {
    func presentScene(scene: SKScene, transition: SKTransition)
}

public extension ScenePresentable where Self: ViewController {
    func presentScene(scene: SKScene, transition: SKTransition) {
        (self.view as! SKView).presentScene(scene, transition: transition)
    }
}
