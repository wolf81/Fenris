//
//  SettingsMenuScene.swift
//  Demo macOS
//
//  Created by Wolfgang Schreurs on 20/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import Fenris
import Cocoa
import SpriteKit

class SettingsMenuScene: MenuScene {
    private let musicItem = ToggleItem(enabled: false)
    private let backItem = ButtonItem(title: "Back")
    
    init(size: CGSize) {
        let menu = LabeledMenuBuilder()
            .withHeader(title: "Settings")
            .withEmptyRow()
            .withRow(title: "Music", item: musicItem)
            .withEmptyRow()
            .withFooter(items: [
                backItem,
                FixedSpaceItem(),
                ButtonItem(title: "Defaults"),
                ButtonItem(title: "Save"),
            ])
            .build()
        
        super.init(size: size, configuration: DefaultMenuConfiguration(), menu: menu)
        
        self.name = "Settings Scene"
        
        self.backItem.onClick = { [unowned self] in
            let scene = MainMenuScene(size: self.size)
            self.view?.presentScene(scene, transition: SKTransition.push(with: .right, duration: 0.5))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
