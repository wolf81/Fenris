//
//  File.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 13/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import SpriteKit

public protocol Highlightable: ControlNode {
    var isHighlighted: Bool { get set }
}

extension Highlightable where Self: ControlNode {
    public var isHighlighted: Bool {
        set(value) {
            guard self.isEnabled == true else { return }
            
            if value == true {
                self.state.insert(.highlighted)
            } else {
                self.state.remove(.highlighted)
            }
            updateForState()
        }
        get {
            return self.state.contains(.highlighted)
        }
    }
}

