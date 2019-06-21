//
//  InputDeviceManager.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 21/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import Foundation
import SpriteKit
import GameKit

enum InputDeviceScheme {
    case mouseKeyboard
    case touch
    case tvRemote
    case gamepad
    
    static var `default`: InputDeviceScheme {
        #if os(iOS)
        return InputDeviceScheme.touch
        #endif
        #if os(macOS)
        return InputDeviceScheme.mouseKeyboard
        #endif
        #if os(tvOS)
        return InputDeviceScheme.tvRemote
        #endif
    }
}

class InputDeviceManager: LocatableService {
    var scheme: InputDeviceScheme = .default {
        didSet {
            print("input scheme changed: \(self.scheme)")
        }
    }
    
    weak var interactableScene: (SKScene & InputDeviceInteractable)?
    
    private var controllers: Controllers!
    
    init() {        
        self.controllers = Controllers(onConnectionChange: { (connected) in
            self.scheme = connected ? .gamepad : .default
        })
        
        self.controllers.discoverWired()
    }    
 }
