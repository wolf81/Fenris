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

final class MainMenuScene: MenuSceneBase {
    private let newGameItem = ButtonItem(title: "New Game")
    private let settingsItem = ButtonItem(title: "Settings")
    private let quitItem = ButtonItem(title: "Quit")
        
    override var configuration: MenuConfiguration { return DefaultMenuConfiguration.shared }

    override func getMenu() -> Menu {
        return SimpleMenuBuilder()
            .withRow(item: self.newGameItem)
            .withEmptyRow()
            .withRow(item: self.settingsItem)
            .withEmptyRow()
            .withRow(item: self.quitItem)
            .build()
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }    
    
    required init(size: CGSize, userInfo: [String : Any]) {
        super.init(size: size, userInfo: userInfo)
        
        self.newGameItem.onClick = {
            try! ServiceLocator.shared.get(service: SceneManager.self).push(to: CreateCharacterMenuScene.self)
        }
        
        self.settingsItem.onClick = {
            try! ServiceLocator.shared.get(service: SceneManager.self).push(to: SettingsMenuScene.self)
        }
                
        self.quitItem.onClick = {
            NSApp.terminate(self)
        }
    }
}

