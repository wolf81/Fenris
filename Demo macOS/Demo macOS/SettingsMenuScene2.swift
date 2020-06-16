//
//  SettingsMenuScene2.swift
//  Demo macOS
//
//  Created by Wolfgang Schreurs on 13/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import Fenris
import SpriteKit

class SettingsMenuScene2: InteractableScene {
    let titleLabel = SKLabelNode(text: "Settings")
    let musicLabel = SKLabelNode(text: "Music")
    let musicButton = TextButtonNode(title: "On", size: CGSize(width: 100, height: 50))
    let backButton = TextButtonNode(title: "Back", size: CGSize(width: 200, height: 50))
        
    var nodes: [SKNode] { [self.titleLabel, self.musicLabel, self.musicButton , self.backButton] }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        self.name = "Settings"
        
        let grid = GridNode(color: .gray, size: CGSize(width: 200, height: 180))
        grid.delegate = self        
        addChild(grid)
        
        grid.position = CGPoint(x: (size.width - grid.size.width) / 2,
                                y: (size.height - grid.size.height) / 2)
        
        self.backButton.onSelected = { [unowned self] _ in self.showMainMenu() } 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Private
    
    func showMainMenu() {
        let scene = MainMenuScene2(size: self.size)
        self.view?.presentScene(scene, transition: SKTransition.push(with: .right, duration: 0.5))
    }
}

extension SettingsMenuScene2: GridNodeDelegate {
    func gridNodeNumberOfRows(_ gridNode: GridNode) -> Int {
        return 3
    }
    
    func gridNode(_ gridNode: GridNode, heightForRow row: Int) -> CGFloat {
        return 60
    }
    
    func gridNode(_ gridNode: GridNode, numberOfItemsInRow row: Int) -> Int {
        switch row {
        case 1: return 2
        default: return 1
        }
    }
    
    func gridNode(_ gridNode: GridNode, nodeForItemAtIndex index: Int) -> SKNode {
        return self.nodes[index]
    }
}
