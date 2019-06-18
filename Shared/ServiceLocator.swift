//
//  File.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 01/08/2018.
//  Copyright © 2018 Wolftrail. All rights reserved.
//

import Foundation

/// The ServiceLocator can be used to register and retrieve various services. Use the service
/// locator to prevent creating a lot of singletons in your codebase. Instead register classes for
/// global use in the service locator and pass the service locator around as a dependency. That way
/// all registered services will stay easily testable.
open class ServiceLocator {
    public private(set) var sceneManager: SceneManagerProtocol
    
    public init() {
        self.sceneManager = DummySceneManager()
    }
    
    public func provide(sceneManager: SceneManagerProtocol) {
        self.sceneManager = sceneManager
    }
}
