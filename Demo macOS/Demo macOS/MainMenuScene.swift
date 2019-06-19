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

final class MainMenuScene: MenuScene & ScenePresentable {
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
            self.present(SettingsMenuScene.self, transition: SceneTransition.crossfade(duration: 0.3))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }    
}

