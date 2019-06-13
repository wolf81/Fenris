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
            let items: [MenuItem] = [
                ButtonMenuItem(title: "Fighter"),
                ButtonMenuItem(title: "assclown"),
                ButtonMenuItem(title: "Test 3"),
                ChooserMenuItem(title: "Test 4", values: ["X"], selectedValueIdx: 0)
            ]
            let font = Font(name: "Helvetica", size: 18)!
            let configuration = MenuConfiguration(menuWidth: 360, itemHeight: 40, font: font)
            let scene = MenuScene(size: view.frame.size, configuration: configuration, items: items)

            // Present the scene
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }    
}

