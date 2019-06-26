//
//  ControllerNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 26/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit
import GameKit

class ControllerNode: SKNode {
    private var controller: GCController?
    
    var onConnectionChanged: ((Bool) -> Void)?
    
    override init() {
        super.init()
        
        addControllerObservers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    deinit {
        removeControllerObservers()
    }
    
    // MARK: - Public
    
    public func connect() {
        self.connectControllers()
    }

    public func readControllerActions() -> InputDeviceAction {
        var actions: InputDeviceAction = .none
        
        guard let gamepad = self.controller?.extendedGamepad else { return actions }
        
        if gamepad.buttonA.isPressed {
            actions.insert(.action1)
        }
        
        if gamepad.buttonB.isPressed {
            actions.insert(.action2)
        }
        
        if gamepad.dpad.up.isPressed || gamepad.leftThumbstick.up.isPressed {
            actions.insert(.up)
        }
        
        if gamepad.dpad.down.isPressed || gamepad.leftThumbstick.down.isPressed {
            actions.insert(.down)
        }
        
        if gamepad.dpad.left.isPressed || gamepad.leftThumbstick.left.isPressed {
            actions.insert(.left)
        }
        
        if gamepad.dpad.right.isPressed || gamepad.leftThumbstick.right.isPressed {
            actions.insert(.right)
        }
        
        return actions
    }

    // MARK: - Private
    
    fileprivate func addControllerObservers() {
        print("add controller observers")
        NotificationCenter.default.addObserver(self, selector: #selector(connectControllers), name: NSNotification.Name.GCControllerDidConnect, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(disconnectControllers), name: NSNotification.Name.GCControllerDidDisconnect, object: nil)
    }
    
    fileprivate func removeControllerObservers() {
        print("remove controller observers")
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.GCControllerDidConnect, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.GCControllerDidDisconnect, object: nil)
    }

    @objc
    private func connectControllers() {
        // FIXME: For some weird reason re-connects don't work properly 99% of the time on macOS and
        // possibly other devices as well. Button touches are received, but the dpad stops working.
        // Why? Need to compare on other platforms, because all seems fine with other games I've
        // tried.
        print("connect controllers")

        self.isPaused = false
        
        let controllers = GCController.controllers()
        
        for controller in controllers {
            controller.playerIndex = .indexUnset

            switch controller {
            case _ where controller.extendedGamepad != nil:
                setupExtendedGamepad(controller)
            case _ where controller.gamepad != nil:
                setupGamepad(controller)
            case _ where controller.microGamepad != nil:
                setupMicroGamepad(controller)
            default: break
            }
        }
        
        onConnectionChanged?(controllers.count > 0)
    }
    
    @objc
    private func disconnectControllers() {
        print("disconnect controllers")
        
        self.isPaused = true
        
        self.controller = nil
        
        onConnectionChanged?(false)
    }

    private func setupMicroGamepad(_ controller: GCController) {
        print("setup micro gamepad")
        controller.playerIndex = .index1
        self.controller = controller
    }
    
    private func setupGamepad(_ controller: GCController) {
        print("setup gamepad")
        controller.playerIndex = .index1
        self.controller = controller
    }
    
    private func setupExtendedGamepad(_ controller: GCController) {
        print("setup extended gamepad")
        controller.playerIndex = .index1
        self.controller = controller
    }
}
