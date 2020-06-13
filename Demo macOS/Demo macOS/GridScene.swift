//
//  GridScene.swift
//  Demo macOS
//
//  Created by Wolfgang Schreurs on 12/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import SpriteKit
import Fenris

class GridScene: InteractableScene {
    override init(size: CGSize) {
        super.init(size: size)

        let newGameButton = ButtonNode(title: "New Game", size: CGSize(width: 200, height: 55), onSelected: { [unowned self] _ in self.showCreateCharacter() })
        let settingsButton = ButtonNode(title: "Settings", size: CGSize(width: 200, height: 55), onSelected: { [unowned self] _ in self.showSettings() })
        let quitButton = ButtonNode(title: "Quit", size: CGSize(width: 200, height: 55), onSelected: { [unowned self] _ in self.quit() })

        let layout = GridLayout(
            rowDefinitions: [
                GridLayout.RowDefinition(),
                GridLayout.RowDefinition(height: 65),
                GridLayout.RowDefinition(height: 65),
                GridLayout.RowDefinition(height: 65),
                GridLayout.RowDefinition(),
            ],
            columnDefinitions: [GridLayout.ColumnDefinition()],
            children: [
                GridLayout.Child(sprite: newGameButton, row: 1, column: 0),
                GridLayout.Child(sprite: settingsButton, row: 2, column: 0),
                GridLayout.Child(sprite: quitButton, row: 3, column: 0),
            ]
        )
        let grid = GridNode(layout: layout, size: size)
        addChild(grid)        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Private
    
    func showCreateCharacter() {
        let createCharacterScene = CreateCharacterMenuScene(size: self.size)
        self.view?.presentScene(createCharacterScene, transition: SKTransition.crossFade(withDuration: 0.5))
    }
    
    func showSettings() {
        let settingsScene = SettingsMenuScene(size: self.size)
        self.view?.presentScene(settingsScene, transition: SKTransition.push(with: .left, duration: 0.5))
    }
    
    func quit() {
        NSApp.terminate(self)
    }
}

