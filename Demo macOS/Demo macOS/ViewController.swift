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
    @IBOutlet var skView: GameView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.skView {
            let scene = CreateCharacterMenuScene2(size: self.view.bounds.size)
//            let scene = MainMenuScene(size: self.view.bounds.size)
            
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        self.view.window?.acceptsMouseMovedEvents = true
    }
}
