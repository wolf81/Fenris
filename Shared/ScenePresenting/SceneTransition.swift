//
//  SceneTransition.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 19/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

public struct SceneTransition {
    
    /// The present animation
    let present: SKTransition
    
    /// The dismiss animation.
    let dismiss: SKTransition
    
    /// Constructor.
    ///
    /// - Parameters:
    ///   - present: A transition to use for presentation.
    ///   - dismiss: A transition to use for dismissal.
    public init(present: SKTransition, dismiss: SKTransition) {
        self.present = present
        self.dismiss = dismiss
    }
    
    public static func pushPop(duration: TimeInterval) -> SceneTransition {
        let present = SKTransition.push(with: .left, duration: duration)
        let dismiss = SKTransition.push(with: .right, duration: duration)
        return SceneTransition(present: present, dismiss: dismiss)
    }
    
    public static func crossfade(duration: TimeInterval) -> SceneTransition {
        let present = SKTransition.crossFade(withDuration: duration)
        let dismiss = SKTransition.crossFade(withDuration: duration)
        return SceneTransition(present: present, dismiss: dismiss)
    }
    
    // MARK: - Internal
    
    internal static func dummy() -> SceneTransition {
        let present = SKTransition()
        let dismiss = SKTransition()
        return SceneTransition(present: present, dismiss: dismiss)
    }
}
