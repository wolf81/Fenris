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
                ButtonMenuItem(title: "Fighter", onClick: {
                    print("touched button")
                }),
                ToggleMenuItem(title: "Music", enabled: false, onValueChanged: { newValue in
                    print("new value: \(newValue)")
                }),
                NumberChooserMenuItem(title: "Strength", range: (6 ... 18), selectedValue: 12, onValueChanged: { newValue in
                    print("new value: \(newValue)")
                }),
                ChooserMenuItem(title: "Class", values: ["Fighter", "Mage", "Thief", "Cleric"], selectedValueIdx: 2, onValueChanged: { newValue in
                    print("new value: \(newValue)")
                })
            ]
//            let font = Font(name: "Baskerville-SemiBoldItalic", size: 18)!
            let font = Font(name: "Papyrus", size: 18)!
            let configuration = MenuConfiguration(menuWidth: 400, itemHeight: 40, font: font)
            let scene = MenuScene(size: view.frame.size, configuration: configuration, items: items)

            // Present the scene
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }    
}

