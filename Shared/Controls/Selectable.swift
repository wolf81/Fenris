//
//  Selectable.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 13/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import SpriteKit

public protocol Selectable: Highlightable {
    var isSelected: Bool { get set }    
}

extension Selectable where Self: ControlNode {
    public var isSelected: Bool {
        set(value) {
            if value == true {
                self.state.insert(.selected)
            } else {
                self.state.remove(.selected)
            }
            updateForState()
        }
        get {
            self.state.contains(.selected)
        }
    }
}
