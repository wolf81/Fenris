//
//  SceneTransitionAnimation.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 01/08/2018.
//  Copyright © 2018 Wolftrail. All rights reserved.
//

import Foundation

/// An enum that is used to specify an animation to use when switching between scenes with the
/// SceneManager.
///
/// - fade: A crossfade animation.
/// - push: A push animation.
/// - pop: A pop animation.
public enum SceneTransitionAnimation {
    case fade
    case push
    case pop
}
