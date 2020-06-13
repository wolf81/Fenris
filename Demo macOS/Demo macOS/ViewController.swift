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
            let scene = GridScene(size: self.view.bounds.size)
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
    
    override func mouseMoved(with event: NSEvent) {
        super.mouseMoved(with: event)
        print("moved")
    }
}
