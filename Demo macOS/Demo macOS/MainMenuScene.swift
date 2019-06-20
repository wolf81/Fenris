//
//  MainMenuScene.swift
//  Demo macOS
//
//  Created by Wolfgang Schreurs on 19/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import Fenris
import Cocoa
import CoreGraphics
import SpriteKit

final class MainMenuScene: MenuScene {
    private let settingsItem = ButtonItem(title: "Settings")
    
    required override init(size: CGSize) {        
        let menu = SimpleMenuBuilder()
            .withRow(item: ButtonItem(title: "New Game"))
            .withEmptyRow()
            .withRow(item: settingsItem)
            .withEmptyRow()
            .withRow(item: ButtonItem(title: "Quit"))
            .build()
        
        super.init(size: size, configuration: DefaultMenuConfiguration(), menu: menu)
        
        self.settingsItem.onClick = {
            let settingsScene = SettingsMenuScene(size: self.size)
            self.view?.presentScene(settingsScene, transition: SKTransition.push(with: .left, duration: 0.5))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }    
}

