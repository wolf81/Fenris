//
//  File.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 13/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import SpriteKit

public protocol Highlightable: SKNode {
    var isHighlighted: Bool { get set }
}
