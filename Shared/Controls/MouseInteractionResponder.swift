//
//  MouseInteractionResponder.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 15/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import SpriteKit

public protocol DeviceInteractable: Highlightable {
    func onEnter()
    
    func onExit()
        
    func onDown()
    
    func onUp()
    
    func onDrag(isTracking: Bool)
}
