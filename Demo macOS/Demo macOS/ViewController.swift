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
    
    private var strength = 12 {
        didSet {
            self.pointsRemaining = self.totalPoints - self.strength - self.agility - self.mind
        }
    }
    
    private var agility = 12 {
        didSet {
            self.pointsRemaining = self.totalPoints - self.strength - self.agility - self.mind
        }
    }
    
    private var mind = 12 {
        didSet {
            self.pointsRemaining = self.totalPoints - self.strength - self.agility - self.mind
        }
    }

    private var pointsRemaining: Int = 0 {
        didSet {
            self.pointsRemainingLabel.title = "\(self.pointsRemaining)"
        }
    }

    private let pointsRemainingLabel = LabelItem(title: "0")

    private func canChangeAttributes(strength: Int, agility: Int, mind: Int) -> Bool {
        let pointsRemaining = self.totalPoints - strength - agility - mind
        let success = pointsRemaining >= 0
        if success {
            self.strength = strength
            self.agility = agility
            self.mind = mind
        }
        return success
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pointsRemaining = self.totalPoints - self.strength - self.agility - self.mind

        if let view = self.skView {            
            let configuration = MenuBuilder.Configuration(
                menuWidth: 460,
                rowHeight: 40,
                titleFont: Font(name: "Papyrus", size: 22)!,
                labelFont: Font(name: "Papyrus", size: 18)!
            )
            
            let menu = MenuBuilder(configuration: configuration)
                .withHeader(title: "New Character")
                .withEmptyRow()
                .withRow(title: "Hard Mode", item: ToggleItem(enabled: true, onValueChange: {
                    print("\($0)"); return true
                }))
                .withRow(title: "Race", item: TextChooserItem(values: ["Human", "Elf", "Dwarf"], selectedValueIdx: 0, onValueChange: {
                    print("\($0)"); return true
                }))
                .withRow(title: "Class", item: TextChooserItem(values: ["Fighter", "Mage", "Thief", "Cleric"], selectedValueIdx: 0, onValueChange: {
                    print("\($0)"); return true
                }))
                .withRow(title: "Strength", item: NumberChooserItem(range: (6 ... 18), selectedValue: 12, onValueChange: { strength in
                    return self.canChangeAttributes(strength: strength, agility: self.agility, mind: self.mind)
                }))
                .withRow(title: "Agility", item: NumberChooserItem(range: (6 ... 18), selectedValue: 12, onValueChange: { agility in
                    return self.canChangeAttributes(strength: self.strength, agility: agility, mind: self.mind)
                }))
                .withRow(title: "Mind", item: NumberChooserItem(range: (6 ... 18), selectedValue: 12, onValueChange: { mind in
                    return self.canChangeAttributes(strength: self.strength, agility: self.agility, mind: mind)
                }))
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
