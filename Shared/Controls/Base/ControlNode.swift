//
//  ControlNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 17/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import SpriteKit

open class ControlNode: SKSpriteNode {
    internal var state: ControlState = .default
    
    public var isEnabled: Bool {
        set(value) {
            if value != self.isEnabled {
                self.state = value == true ? .default : .disabled
                updateForState()
            }
        }
        get {
            return self.state != .disabled
        }
    }
    
    public init(size: CGSize = .zero) {
        super.init(texture: nil, color: .clear, size: size)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func updateForState() {
        switch self.state {
        case _ where self.state == .disabled: self.run(SKAction.fadeAlpha(to: 0.5, duration: 0.1))
        default: self.run(SKAction.fadeAlpha(to: 1.0, duration: 0.1))
        }
    }
}
