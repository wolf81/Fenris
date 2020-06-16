//
//  MouseInteractionResponder.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 15/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import SpriteKit

public protocol MouseDeviceInteractable: SKNode {
    func onMouseEnter()
    
    func onMouseExit()
        
    func onMouseDown()
    
    func onMouseUp()
    
    func onMouseDrag(isTracking: Bool) 
}
