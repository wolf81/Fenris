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
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

        self.attributeUpdater = AttributeUpdater(
            strength: 12,
            agility: 12,
            mind: 12,
            onPointsRemainingUpdated: { (pointsRemaining) in
            self.pointsRemainingLabel.title = "\(pointsRemaining)"
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pointsRemainingLabel.title = "\(attributeUpdater.pointsRemaining)"
        
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
                    return self.attributeUpdater.update(strength: strength)
                }))
                .withRow(title: "Agility", item: NumberChooserItem(range: (6 ... 18), selectedValue: 12, onValueChange: { agility in
                    return self.attributeUpdater.update(agility: agility)
                }))
                .withRow(title: "Mind", item: NumberChooserItem(range: (6 ... 18), selectedValue: 12, onValueChange: { mind in
                    return self.attributeUpdater.update(mind: mind)
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
