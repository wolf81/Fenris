//
//  MainMenuScene.swift
//  Demo macOS
//
//  Created by Wolfgang Schreurs on 19/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import Fenris
import Cocoa
import SpriteKit

final class MainMenuScene: MenuScene {
    private let newGameItem = ButtonItem(title: "New Game")
    private let settingsItem = ButtonItem(title: "Settings")
    private let quitItem = ButtonItem(title: "Quit")
    
    init(size: CGSize) {
        let menu = SimpleMenuBuilder()
            .withRow(item: self.newGameItem)
            .withEmptyRow()
            .withRow(item: self.settingsItem)
            .withEmptyRow()
            .withRow(item: self.quitItem)
            .build()
        
        super.init(size: size, configuration: DefaultMenuConfiguration(), menu: menu)

        self.name = "Main Menu Scene"

        self.newGameItem.onClick = { [unowned self] in
            let createCharacterScene = CreateCharacterMenuScene(size: self.size)
            self.view?.presentScene(createCharacterScene, transition: SKTransition.crossFade(withDuration: 0.5))
        }
        
        self.settingsItem.onClick = { [unowned self] in
            let settingsScene = SettingsMenuScene(size: self.size)
            self.view?.presentScene(settingsScene, transition: SKTransition.push(with: .left, duration: 0.5))
        }
        
        self.quitItem.onClick = { [unowned self] in
            NSApp.terminate(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }    
}

