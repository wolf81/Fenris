//
//  ScenePresentable.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 01/08/2018.
//  Copyright © 2018 Wolftrail. All rights reserved.
//

import Foundation
import SpriteKit

public protocol ScenePresentor where Self: ViewController {
    func presentScene(scene: SKScene, transition: SKTransition)
}

public extension ScenePresentor where Self: ViewController {
    func presentScene(scene: SKScene, transition: SKTransition) {
        guard self.view is SKView else {
            print("[ERROR] Invalid view, view should be of type SKView")
            return
        }
        
        (self.view as! SKView).presentScene(scene, transition: transition)
    }
}
