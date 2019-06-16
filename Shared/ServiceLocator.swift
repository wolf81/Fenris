//
//  File.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 01/08/2018.
//  Copyright © 2018 Wolftrail. All rights reserved.
//

import Foundation

/// The ServiceLocator can be used to register and retrieve various services. The ServiceLocator
/// should be the only singleton in a game. When it's tempting to use a singleton for some purpose,
/// instead consider extending the service locator to register and retrieve your class. This way
/// your code should be more easily testable.
open class ServiceLocator {
    public static let shared = ServiceLocator()
    
    public private(set) var sceneManager: SceneManagerProtocol
    
    private init() {
        self.sceneManager = DummySceneManager()
    }
    
    public func provide(sceneManager: SceneManagerProtocol) {
        self.sceneManager = sceneManager
    }
}
