//
//  MenuNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 02/08/2018.
//  Copyright © 2018 Wolftrail. All rights reserved.
//

import SpriteKit

protocol MenuNode where Self: SKShapeNode {
    var titleLabelMaxX: CGFloat { get }
    var spacing: CGFloat { get }
}

extension MenuNode where Self: SKShapeNode {
    var spacing: CGFloat {
        return 30
    }
}
