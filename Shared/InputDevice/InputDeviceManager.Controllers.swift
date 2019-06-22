//
//  InputDeviceManager.Controllers.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 21/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import GameKit

extension InputDeviceManager {
    class Controllers {
        private var onConnectionChange: ((Bool) -> Void)
        
        private var buttonAPressHandler: ((GCControllerButtonInput, Float, Bool) -> ()) = { input, value, pressed in
            let deviceManager = try! ServiceLocator.shared.get(service: InputDeviceManager.self)
            
            guard deviceManager.scheme == .gamepad else { return }
            if pressed {
                deviceManager.interactableScene?.handleInput(action: .buttonA)
            }
        }
        private var buttonBPressHandler: ((GCControllerButtonInput, Float, Bool) -> ()) = { input, value, pressed in
            let deviceManager = try! ServiceLocator.shared.get(service: InputDeviceManager.self)
            
            guard deviceManager.scheme == .gamepad else { return }
            if pressed {
                deviceManager.interactableScene?.handleInput(action: .buttonB)
            }
        }
        private var dpadUpHandler: ((GCControllerButtonInput, Float, Bool) -> ()) = { input, value, pressed in
            let deviceManager = try! ServiceLocator.shared.get(service: InputDeviceManager.self)
            
            guard deviceManager.scheme == .gamepad else { return }
            if pressed {
                deviceManager.interactableScene?.handleInput(action: .up)
            }
        }
        private var dpadDownHandler: ((GCControllerButtonInput, Float, Bool) -> ()) = { input, value, pressed in
            let deviceManager = try! ServiceLocator.shared.get(service: InputDeviceManager.self)
            
            guard deviceManager.scheme == .gamepad else { return }
            if pressed {
                deviceManager.interactableScene?.handleInput(action: .down)
            }
        }
        private var dpadLeftHandler: ((GCControllerButtonInput, Float, Bool) -> ()) = { input, value, pressed in
            let deviceManager = try! ServiceLocator.shared.get(service: InputDeviceManager.self)
            
            guard deviceManager.scheme == .gamepad else { return }
            if pressed {
                deviceManager.interactableScene?.handleInput(action: .left)
            }
        }
        private var dpadRightHandler: ((GCControllerButtonInput, Float, Bool) -> ()) = { input, value, pressed in
            let deviceManager = try! ServiceLocator.shared.get(service: InputDeviceManager.self)
            
            guard deviceManager.scheme == .gamepad else { return }
            if pressed {
                deviceManager.interactableScene?.handleInput(action: .right)
            }
        }
        private var pauseHandler: (GCController) -> Void = { controller in
            let deviceManager = try! ServiceLocator.shared.get(service: InputDeviceManager.self)
            
            guard deviceManager.scheme == .gamepad else { return }
            deviceManager.interactableScene?.handleInput(action: .pause)
        }
        
        var player1: GCController? = nil {
            didSet {
                if let controller = self.player1 {
                    controller.playerIndex = .index1
                }
            }
        }
        
        init(onConnectionChange: @escaping (Bool) -> Void) {
            self.onConnectionChange = onConnectionChange
            
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(controllerDidConnect(_:)),
                name: NSNotification.Name.GCControllerDidConnect, object: nil
            )
            
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(controllerDidDisconnect(_:)),
                name: NSNotification.Name.GCControllerDidDisconnect, object: nil
            )
        }
        
        deinit {
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name.GCControllerDidConnect, object: nil)
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name.GCControllerDidDisconnect, object: nil)
        }
        
        func connect() {
            if let controller = GCController.controllers().first {
                self.player1 = controller
                configure(controller: controller)
            }
        }
        
        func disconnect() {
            self.player1 = nil
            if GCController.controllers().count == 0 {
                onConnectionChange(false)
            }
        }
        
        func startWirelessDiscovery() {
            // TODO: Implement support for wireless controllers
            fatalError()
        }
        
        func stopWirelessDiscovery() {
            // TODO: Implement support for wireless controllers
            fatalError()
        }
        
        private var controller: GCController?
        
        private func configure(controller: GCController) {
            controller.controllerPausedHandler = self.pauseHandler

            if let gamepad = controller.gamepad { // TODO: Add support for multiple players?
                gamepad.dpad.up.pressedChangedHandler = self.dpadUpHandler
                gamepad.dpad.down.pressedChangedHandler = self.dpadDownHandler
                gamepad.dpad.left.pressedChangedHandler = self.dpadLeftHandler
                gamepad.dpad.right.pressedChangedHandler = self.dpadRightHandler
                gamepad.buttonA.pressedChangedHandler = self.buttonAPressHandler
                gamepad.buttonB.pressedChangedHandler = self.buttonBPressHandler
            } else if let _ = controller.microGamepad { // TODO: Add support for siri remote
                fatalError()
            } else if let _ = controller.extendedGamepad { // TODO: Add support for extended gamepad
                fatalError()
            }
            
            onConnectionChange(true)
        }
        
        @objc private func controllerDidConnect(_ notification: Notification) {
            let controller = notification.object as! GCController
            print("connected: \(controller)")
            connect()
        }
        
        @objc private func controllerDidDisconnect(_ notification: Notification) {
            let controller = notification.object as! GCController
            print("disconnected: \(controller)")
            disconnect()
        }
    }
}
