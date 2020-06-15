//
//  CreateCharacterMenuScene2.swift
//  Demo macOS
//
//  Created by Wolfgang Schreurs on 15/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import Fenris
import SpriteKit

class CreateCharacterMenuScene2: InteractableScene {
    let titleLabel = SKLabelNode(text: "Create Character")
    let textChooser = TextChooserNode(values: ["Mage", "Fighter", "Rogue", "Cleric"], size: CGSize(width: 200, height: 50))
    let numberChooser = NumberChooserNode(values: [1, 2, 4, 6], size: CGSize(width: 200, height: 50))
    let backButton = ButtonNode(title: "Back", size: CGSize(width: 100, height: 50))

    var nodes: [SKNode] { [self.titleLabel, self.textChooser, self.numberChooser, self.backButton] }

    override init(size: CGSize) {
        super.init(size: size)
        
        let grid = GridNode(color: .gray, size: CGSize(width: 250, height: 180))
        addChild(grid)
        grid.delegate = self
        grid.position = CGPoint(x: (size.width - grid.size.width) / 2,
                                y: (size.height - grid.size.height) / 2)
        
//        self.backButton.onStateChanged = { [unowned self] button in if button.isSelected { self.showMainMenu() } }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}


extension CreateCharacterMenuScene2: GridNodeDelegate {
    func gridNodeNumberOfRows(_ gridNode: GridNode) -> Int {
        return 3
    }
    
    func gridNode(_ gridNode: GridNode, heightForRow row: Int) -> CGFloat {
        return 60
    }
    
    func gridNode(_ gridNode: GridNode, numberOfItemsInRow row: Int) -> Int {
        return 1
//        switch row {
//        case 1: return 2
//        default: return 1
//        }
    }
    
    func gridNode(_ gridNode: GridNode, nodeForItemAtIndex index: Int) -> SKNode {
        return self.nodes[index]
    }
}
