//
//  GameScene.swift
//  Demo macOS
//
//  Created by Wolfgang Schreurs on 20/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import Fenris
import SpriteKit

class GameScene: InputDeviceInteractableScene {
    override func handleInput(action: GameControllerAction) {
        switch action {
        case _ where action.contains(.pause):
            let menuScene = MainMenuScene(size: self.size)
            self.view?.presentScene(menuScene, transition: SKTransition.crossFade(withDuration: 0.5))
        default: break
        }
    }
    
    override func updateForInputDevice(_ scheme: InputDeviceScheme) {
        print("new input device scheme: \(scheme)")
    }
}
