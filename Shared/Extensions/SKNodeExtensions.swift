//
//  SKNodeExtensions.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 15/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import SpriteKit

extension SKNode {
    func clearHighlightingOnChildNodes() {
        if let highlightable = self as? Highlightable, highlightable.isHighlighted {
            highlightable.isHighlighted = false
        }

        for node in self.children {
            node.clearHighlightingOnChildNodes()
        }
    }    
}
