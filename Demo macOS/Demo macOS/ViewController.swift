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
    
    private let totalPoints = 42
    private var strength = 12
    private var agility = 12
    private var mind = 12
    
    private var pointsRemaining: Int {
        return self.totalPoints - self.strength - self.agility - self.mind
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let view = self.skView {            
            let configuration = MenuBuilder.Configuration(
                menuWidth: 460,
                rowHeight: 40,
                titleFont: Font(name: "Papyrus", size: 22)!,
                labelFont: Font(name: "Papyrus", size: 18)!
            )
            
            let pointsRemainingLabel = LabelItem(title: "0")
            let menu = MenuBuilder(configuration: configuration)
                .withHeader(title: "New Character")
                .withEmptyRow()
                .withRow(title: "Hard Mode", item: ToggleItem(enabled: true))
                .withRow(title: "Race", item: TextChooserItem(values: ["Human", "Elf", "Dwarf"], selectedValueIdx: 0))
                .withRow(title: "Class", item: TextChooserItem(values: ["Fighter", "Mage", "Thief", "Cleric"], selectedValueIdx: 0))
                .withRow(title: "Strength", item: NumberChooserItem(range: (6 ... 18), selectedValue: 12))
                .withRow(title: "Agility", item: NumberChooserItem(range: (6 ... 18), selectedValue: 12))
                .withRow(title: "Mind", item: NumberChooserItem(range: (6 ... 18), selectedValue: 12))
                .withRow(title: "Points Remaining", item: pointsRemainingLabel)
                .build()
            
            let scene = MenuScene(size: self.view.bounds.size, menu: menu)
            
            // Present the scene
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }    
}
