//
//  InputDeviceInteractableScene.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 20/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit
import GameKit

open class InputDeviceInteractableScene: SKScene {
    private var inputScheme: InputDeviceScheme = .default {
        didSet {
            didChangeInputScheme(self.inputScheme)
        }
    }
    
    // TODO: in the future the controller node might add some HUD for iOS devices - something to
    // think about
    private let controllerNode: ControllerNode = ControllerNode()
    
    // TODO: should load this from some settings file, allowing the user to change the keys
    private var keyActionInfo: [UInt16: InputDeviceAction] = [
        126: .up,
        125: .down,
        123: .left,
        124: .right,
        49: .action1,
        53: .action2
    ]

    private var lastActions: InputDeviceAction = .none
    
    public var inputActions: InputDeviceAction = .none {
        didSet {
            var filteredActions = self.inputActions
            filteredActions.removePointUp()
            
            // compare with last actions to see if press state was changed for some buttons
            if filteredActions != self.lastActions {
                // retrieve the action that is changed compared to last update
                let action = self.lastActions.symmetricDifference(filteredActions)
                
                // make a mask of the action
                let mask = self.inputActions.rawValue & action.rawValue
                
                // get the value of the action using the mask
                let value = self.inputActions.rawValue & mask
                
                // if the value did become 0, the button was released, otherwise it's pressed
                onInputActionChange(action, isPressed: value != 0)
            }
            
            self.lastActions = filteredActions
        }
    }
        
    open override func didMove(to view: SKView) {
        super.didMove(to: view)

        // whenever a scene moves to a view, connect controllers if needed and receive
        // notifications whenever the input scheme changes
        self.addChild(self.controllerNode)
        self.controllerNode.connect()
        self.controllerNode.onConnectionChanged = { [unowned self] connected in
            self.inputScheme = connected ? .gamepad : .default
        }
    }
    
    deinit {
        self.controllerNode.removeFromParent()
    }
    
    public func onInputActionChange(_ action: InputDeviceAction, isPressed: Bool) {
        switch action {
        case _ where action.contains(.up) && !isPressed: print("up")
        case _ where action.contains(.down) && !isPressed: print("down")
        default:
            print("action: \(action) - pressed: \(isPressed)")
        }
    }
    
    open override func update(_ currentTime: TimeInterval) {
        self.inputActions = self.controllerNode.readControllerActions()
        
        switch self.inputActions {
        case _ where inputActions.contains(.up): print("move up")
        case _ where inputActions.contains(.down): print("move down")
        case _ where inputActions.contains(.left): print("move left")
        case _ where inputActions.contains(.right): print("move right")
        case _ where inputActions.contains(.pause): print("-- pause -- ")
        default: break
        }
        
//        if let pointUp = inputActions.getPointUp() {
//            print("handle touch @ \(pointUp)")
//            inputActions.removePointUp()
//        } else if let pointMove = inputActions.getPointMove() {
//            print("handle move @ \(pointMove)")
//            let position = pointMove.cgPoint
//        }
    }
    
    public func didChangeInputScheme(_ inputScheme: InputDeviceScheme) {
        // overridable by subclasses
    }
}

#if os(macOS)

extension InputDeviceInteractableScene {
    open override func mouseUp(with event: NSEvent) {
        guard self.inputScheme == .mouseKeyboard else { return }
        
        let location = event.location(in: self)
        self.inputActions.setPointUp(location.point)
    }
    
    open override func mouseDown(with event: NSEvent) {
        guard self.inputScheme == .mouseKeyboard else { return }

        // ...
    }
    
    open override func mouseMoved(with event: NSEvent) {
        guard self.inputScheme == .mouseKeyboard else { return }

        let location = event.location(in: self)
        self.inputActions.setPointMove(location.point)
    }
    
    open override func keyUp(with event: NSEvent) {
        guard self.inputScheme == .mouseKeyboard else { return }

        if let action = self.keyActionInfo[event.keyCode] {
            self.inputActions.remove(action)
        }
    }
    
    open override func keyDown(with event: NSEvent) {
        guard self.inputScheme == .mouseKeyboard else { return }

        if let action = self.keyActionInfo[event.keyCode] {
            self.inputActions.insert(action)
        }
    }
}

#endif

#if os(iOS)

extension MenuScene {
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard self.inputScheme == .touch else { return }

        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: self)
        print("handle touch end @ \(location)")
    }
}

#endif
