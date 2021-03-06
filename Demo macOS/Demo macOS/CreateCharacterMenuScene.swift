//
//  SettingsMenuScene.swift
//  Demo macOS
//
//  Created by Wolfgang Schreurs on 19/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import Fenris
import Cocoa
import SpriteKit

final class CreateCharacterMenuScene: MenuSceneBase {
    override var configuration: MenuConfiguration { return DefaultMenuConfiguration.shared }

    private var attributeUpdater: AttributeUpdater!

    private let pointsRemainingLabel = LabelItem(title: "0")
    private let strengthChooser = NumberChooserItem(range: (6 ... 18), selectedValue: 12)
    private let dexterityChooser = NumberChooserItem(range: (6 ... 18), selectedValue: 12)
    private let mindChooser = NumberChooserItem(range: (6 ... 18), selectedValue: 12, onValueChanged: { newValue in
        print("new value: \(newValue)")
    })
    private let raceChooser = TextChooserItem(values: ["Human", "Elf", "Dwarf", "Halfling"], selectedValueIdx: 0, onValueChanged: { newValue in
        print("new value: \(newValue)")
    })
    private let backItem = ButtonItem(title: "Back")

    private let nextItem = ButtonItem(title: "Next")
    
    override func getMenu() -> Menu {
        return LabeledMenuBuilder()
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
                self.backItem,
                self.nextItem,
                ]).build()
    }
    
    required init(size: CGSize, userInfo: [String : Any]) {
        super.init(size: size, userInfo: userInfo)
        
        self.backItem.onClick = {
            try! ServiceLocator.shared.get(service: SceneManager.self).pop(to: MainMenuScene.self)
        }
        
        self.nextItem.onClick = {
            try! ServiceLocator.shared.get(service: SceneManager.self).fade(to: LoadingScene.self)
        }
        
        self.attributeUpdater = AttributeUpdater(
            strength: 12,
            dexterity: 12,
            mind: 12,
            onPointsRemainingUpdated: { [unowned self] pointsRemaining in
                self.pointsRemainingLabel.title = "\(pointsRemaining)"
        })
        
        self.pointsRemainingLabel.title = "\(attributeUpdater.pointsRemaining)"
        
        self.strengthChooser.onValidate = { [unowned self] strength in
            return self.attributeUpdater.update(strength: strength)
        }
        
        self.dexterityChooser.onValidate = { [unowned self] dexterity in
            return self.attributeUpdater.update(dexterity: dexterity)
        }
        
        self.mindChooser.onValidate = { [unowned self] mind in
            return self.attributeUpdater.update(mind: mind)
        }
        
        self.raceChooser.onValidate = { [unowned self] raceIdx in
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
