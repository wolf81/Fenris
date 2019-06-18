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
    
    private var attributeUpdater: AttributeUpdater!
    
    private let pointsRemainingLabel = LabelItem(title: "0")
    private let strengthChooser = NumberChooserItem(range: (6 ... 18), selectedValue: 12)
    private let dexterityChooser = NumberChooserItem(range: (6 ... 18), selectedValue: 12)
    private let mindChooser = NumberChooserItem(range: (6 ... 18), selectedValue: 12)
    private let raceChooser = TextChooserItem(values: ["Human", "Elf", "Dwarf", "Halfling"], selectedValueIdx: 0)
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

        self.attributeUpdater = AttributeUpdater(
            strength: 12,
            dexterity: 12,
            mind: 12,
            onPointsRemainingUpdated: { (pointsRemaining) in
            self.pointsRemainingLabel.title = "\(pointsRemaining)"
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pointsRemainingLabel.title = "\(attributeUpdater.pointsRemaining)"
        
        if let view = self.skView {            
            let configuration = MenuConfiguration(
                menuWidth: 460,
                rowHeight: 40,
                titleFont: Font(name: "Papyrus", size: 22)!,
                labelFont: Font(name: "Papyrus", size: 18)!
            )
            
            /*
            let menu = LabeledMenuBuilder()
                .withHeader(title: "New Character")
                .withEmptyRow()
                .withRow(title: "Hard Mode", item: ToggleItem(enabled: true))
                .withRow(title: "Race", item: raceChooser)
                .withRow(title: "Class", item: TextChooserItem(values: ["Fighter", "Mage", "Thief", "Cleric"], selectedValueIdx: 0))
                .withRow(title: "Strength", item: strengthChooser)
                .withRow(title: "Agility", item: dexterityChooser)
                .withRow(title: "Mind", item: mindChooser)
                .withRow(title: "Points Remaining", item: pointsRemainingLabel)
                .withEmptyRow()
                .withFooter(items: [
                    ButtonItem(title: "Back", onClick: { print("clicked back") }),
                    FixedSpaceItem(),
                    ButtonItem(title: "Defaults", onClick: { print("clicked defaults") }),
                    ButtonItem(title: "Save", onClick: { print("clicked save") }),
                ]).build()
                */
            let menu = SimpleMenuBuilder()
                .withRow(item: ButtonItem(title: "New Game", onClick: { print("new game") }))
                .withEmptyRow()
                .withRow(item: ButtonItem(title: "Settings", onClick: { print("settings") }))
                .withEmptyRow()
                .withRow(item: ButtonItem(title: "Quit", onClick: { print("quit") }))
                .build()
            
            let scene = MenuScene(size: self.view.bounds.size, configuration: configuration, menu: menu)
            
            self.strengthChooser.onValidate = { strength in
                return self.attributeUpdater.update(strength: strength)
            }

            self.dexterityChooser.onValidate = { dexterity in
                return self.attributeUpdater.update(dexterity: dexterity)
            }

            self.mindChooser.onValidate = { mind in
                return self.attributeUpdater.update(mind: mind)
            }
            
            self.raceChooser.onValidate = { raceIdx in
                var strengthRange = (6 ... 18)
                var dexterityRange = (6 ... 18)
                var mindRange = (6 ... 18)
                
                switch raceIdx {
                case 0: /* Human */
                    break
                case 1: /* Elf */
                    mindRange = (8 ... 20)
                case 2: /* Dwarf */
                    strengthRange = (8 ... 20)
                case 3: /* Halfling */
                    dexterityRange = (8 ... 20)
                default: fatalError()
                }
                
                self.strengthChooser.range = strengthRange
                self.dexterityChooser.range = dexterityRange
                self.mindChooser.range = mindRange
                
                return true
            }
            
            // Present the scene
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }    
}
