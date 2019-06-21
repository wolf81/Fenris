//
//  InputDeviceInteractableScene.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 20/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

open class InputDeviceInteractableScene: SKScene & InputDeviceInteractable {
    open func handleMouseUp(location: CGPoint) {
    }
    
    open func handleMouseMoved(location: CGPoint) {
    }
    
    open func handleInput(action: GameControllerAction) {
    }
    
    open func handleKeyUp(action: KeyboardAction) {
    }
    
    open func updateForInputDevice(_ scheme: InputDeviceScheme) {
    }
    
    open override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        initializeInputDeviceManagerIfNeeded(scene: self, onInputDeviceChanged: { [unowned self] scheme in
            self.updateForInputDevice(scheme)
        })
    }    
}

#if os(macOS)

extension InputDeviceInteractableScene {
    open override func mouseUp(with event: NSEvent) {
        guard
            let inputDeviceManager = try? ServiceLocator.shared.get(service: InputDeviceManager.self),
            inputDeviceManager.scheme == .mouseKeyboard else {
            return
        }

        let location = event.location(in: self)
        handleMouseUp(location: location)
    }
    
    open override func mouseMoved(with event: NSEvent) {
        guard
            let inputDeviceManager = try? ServiceLocator.shared.get(service: InputDeviceManager.self),
            inputDeviceManager.scheme == .mouseKeyboard else {
                return
        }

        let location = event.location(in: self)
        handleMouseMoved(location: location)
    }
    
    open override func keyUp(with event: NSEvent) {
        guard
            let inputDeviceManager = try? ServiceLocator.shared.get(service: InputDeviceManager.self),
            inputDeviceManager.scheme == .mouseKeyboard else {
                return
        }

        // TODO: A keymap file might be used bind key codes with key actions, this could be part of
        // the app settings and provide a default implementation that can be changed
        
        switch event.keyCode {
        case 126: handleKeyUp(action: .up)
        case 125: handleKeyUp(action: .down)
        case 123: handleKeyUp(action: .left)
        case 124: handleKeyUp(action: .right)
        case 49: handleKeyUp(action: .action1)
        case 53: handleKeyUp(action: .action2)
        default: break
        }
    }
    
    open override func keyDown(with event: NSEvent) {
        guard
            let inputDeviceManager = try? ServiceLocator.shared.get(service: InputDeviceManager.self),
            inputDeviceManager.scheme == .mouseKeyboard else {
                return
        }

        // We override this method to silence the macOS beep on key press
    }
}

#endif

#if os(iOS)

extension MenuScene {
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: self)
        print("handle touch end @ \(location)")
    }
}

#endif



