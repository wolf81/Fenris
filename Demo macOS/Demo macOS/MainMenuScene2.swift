//
//  MainMenuScene2.swift
//  Demo macOS
//
//  Created by Wolfgang Schreurs on 13/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import Fenris
import SpriteKit

class MainMenuScene2: InteractableScene {
    let newGameButton = ButtonNode(title: "New Game", size: CGSize(width: 200, height: 50)) //, onSelected: { [unowned self] _ in self.showCreateCharacter() })
    let settingsButton = ButtonNode(title: "Settings", size: CGSize(width: 200, height: 50)) //, onSelected: { [unowned self] _ in self.showSettings() })
    let quitButton = ButtonNode(title: "Quit", size: CGSize(width: 200, height: 50)) //, onSelected: { [unowned self] _ in self.quit() })
    
    let scrollNode: ScrollNode

    var menuNodes: [SKNode] { [self.newGameButton, self.settingsButton, self.quitButton] }
    
    override init(size: CGSize) {
        self.scrollNode = ScrollNode(texture: nil, color: .brown, size: CGSize(width: 200, height: 200))

        super.init(size: size)

        let texture = SKTexture(noiseWithSmoothness: 0.6, size: CGSize(width: 200, height: 1000), grayscale: false)
        let sprite = SKSpriteNode(texture: texture)
        self.scrollNode.addContent(sprite: sprite)
        
//        self.scrollNode.anchorPoint = .zero
        self.scrollNode.position = CGPoint(x: 10, y: 10)
        addChild(self.scrollNode)

        let grid = GridNode(color: .gray, size: CGSize(width: 200, height: 180))
        grid.delegate = self
        addChild(grid)
        
        grid.position = CGPoint(x: (size.width - grid.size.width) / 2,
                                y: (size.height - grid.size.height) / 2)
        
        self.newGameButton.onStateChanged = { [unowned self] button in if button.isSelected { self.showCreateCharacter() } }
        self.settingsButton.onStateChanged = { [unowned self] button in if button.isSelected { self.showSettings() } }
        self.quitButton.onStateChanged = { [unowned self] button in if button.isSelected { self.quit() } }
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
        let settingsScene = SettingsMenuScene2(size: self.size)
        self.view?.presentScene(settingsScene, transition: SKTransition.push(with: .left, duration: 0.5))
    }
    
    func quit() {
        NSApp.terminate(self)
    }
}

extension MainMenuScene2: GridNodeDelegate {
    func gridNodeNumberOfRows(_ gridNode: GridNode) -> Int {
        return self.menuNodes.count
    }
    
    func gridNode(_ gridNode: GridNode, heightForRow row: Int) -> CGFloat {
        return 60
    }
    
    func gridNode(_ gridNode: GridNode, numberOfItemsInRow row: Int) -> Int {
        return 1
    }
    
    func gridNode(_ gridNode: GridNode, nodeForItemAtIndex index: Int) -> SKNode {
        self.menuNodes[index]
    }
}

