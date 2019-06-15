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
//            let labelItem = LabelMenuItem(title: "Points Remaining", value: "\(self.pointsRemaining)")

            /*
            let items: [MenuItem] = [
                ButtonMenuItem(title: "Settings", onClick: {
                    print("touched button")
                }),
                ToggleMenuItem(title: "Music", enabled: false, onValueChanged: { newValue in
                    print("new value: \(newValue)")
                    return true
                }),
                ToggleMenuItem(title: "Sounds", enabled: true, onValueChanged: { newValue in
                    print("new value: \(newValue)")
                    return true
                }),
                NumberChooserMenuItem(title: "Strength", range: (6 ... 18), selectedValue: self.strength, onValueChanged: { newValue in
                    let success = self.totalPoints - self.agility - self.mind - newValue >= 0
                    if success { self.strength = newValue }
                    labelItem.value = "\(self.pointsRemaining)"
                    return success
                }),                
                NumberChooserMenuItem(title: "Agility", range: (6 ... 18), selectedValue: self.agility, onValueChanged: { newValue in
                    let success = self.totalPoints - self.strength - self.mind - newValue >= 0
                    if success { self.agility = newValue }
                    labelItem.value = "\(self.pointsRemaining)"
                    return success
                }),
                NumberChooserMenuItem(title: "Mind", range: (6 ... 18), selectedValue: self.mind, onValueChanged: { newValue in
                    let success = self.totalPoints - self.agility - self.strength - newValue >= 0
                    if success { self.mind = newValue }
                    labelItem.value = "\(self.pointsRemaining)"
                    return success
                }),
                ChooserMenuItem(title: "Race", values: ["Human", "Elf", "Dwarf"], selectedValueIdx: 0, onValueChanged: { newValue in
                    print("new value: \(newValue)")
                    return true
                }),
                ChooserMenuItem(title: "Class", values: ["Fighter", "Mage", "Thief", "Cleric"], selectedValueIdx: 2, onValueChanged: { newValue in
                    print("new value: \(newValue)")
                    return true
                }),
                labelItem
            ]
             */
            
            let configuration = Menu.Configuration(
                menuWidth: 460,
                rowHeight: 40,
                titleFont: Font(name: "Baskerville-SemiBoldItalic", size: 18)!,
                labelFont: Font(name: "Papyrus", size: 18)!
            )
                        
            let items: [Item] = [
                LabelItem(title: "Test 1"), FixedSpaceItem(),
                LabelItem(title: "Class"), TextChooserItem(values: ["Fighter", "Mage", "Thief", "Cleric"], selectedValue: "Fighter"),
                FixedSpaceItem(), LabelItem(title: "Agility"),
                LabelItem(title: "Strength"), NumberChooserItem(range: (6 ... 18), selectedValue: 12),
                LabelItem(title: "Music"), ToggleItem(enabled: false),
                FixedSpaceItem(), FixedSpaceItem(),
                ButtonItem(title: "Button 1"), ButtonItem(title: "Button 2")
            ]
            let menu = Menu(title: "Settings", items: items, configuration: configuration)
            let scene = MenuScene(size: self.view.bounds.size, menu: menu)
            
            // Present the scene
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }    
}
