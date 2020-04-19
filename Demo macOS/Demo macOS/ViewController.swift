//
//  ViewController.swift
//  Demo macOS
//
//  Created by Wolfgang Schreurs on 13/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import Cocoa
import SpriteKit
import Fenris

class ViewController: NSViewController {
    @IBOutlet var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.skView {
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true

            let sceneManager = SceneManager(view: view)
            try! ServiceLocator.shared.add(service: sceneManager)
        }
        
        try! ServiceLocator.shared.get(service: SceneManager.self).fade(to: MainMenuScene.self)
    }    
}
