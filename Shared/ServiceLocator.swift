//
//  File.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 01/08/2018.
//  Copyright © 2018 Wolftrail. All rights reserved.
//

import Foundation

public class ServiceLocator {
    public static let shared = ServiceLocator()
    
    public private(set) var sceneManager: SceneManagerProtocol
    
    private init() {
        self.sceneManager = DummySceneManager()
    }
    
    public func register(sceneManager: SceneManagerProtocol) {
        self.sceneManager = sceneManager
    }
}
