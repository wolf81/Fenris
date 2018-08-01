//
//  ScenePresentable.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 01/08/2018.
//  Copyright © 2018 Wolftrail. All rights reserved.
//

import Foundation
import SpriteKit

public protocol ScenePresentable: class {
    func presentScene(scene: SKScene, transition: SKTransition)
}

#if os(macOS)
import Cocoa

public extension ScenePresentable where Self: NSViewController {
    func presentScene(scene: SKScene, transition: SKTransition) {
        (self.view as! SKView).presentScene(scene, transition: transition)
    }
}
#endif

#if os(iOS)
import UIKit

public extension ScenePresentable where Self: UIViewController {
    func presentScene(scene: SKScene, transition: SKTransition) {
        (self.view as! SKView).presentScene(scene, transition: transition)
    }
}
#endif
