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

class SettingsMenuScene: MenuSceneBase {
    override var configuration: MenuConfiguration { return DefaultMenuConfiguration.shared }

    private let musicItem = ToggleItem(enabled: false, onValueChanged: { newValue in
        print("new value: \(newValue)")
    })
    private let backItem = ButtonItem(title: "Back")
    
    override func getMenu() -> Menu {
        return LabeledMenuBuilder()
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    required init(size: CGSize, userInfo: [String : Any]) {
        super.init(size: size, userInfo: userInfo)
        
        self.backItem.onClick = { [unowned self] in
            let scene = MainMenuScene(size: self.size, userInfo: userInfo)
            self.view?.presentScene(scene, transition: SKTransition.push(with: .right, duration: 0.5))
        }
    }
}
