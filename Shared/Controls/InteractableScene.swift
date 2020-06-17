//
//  InteractableScene.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 13/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import SpriteKit

open class InteractableScene: SKScene {
    private var currentNodes: [MouseDeviceInteractable] = []
    
    override open func sceneDidLoad() {
        super.sceneDidLoad()
        
        self.isUserInteractionEnabled = true
    }

    override open func didMove(to view: SKView) {
        super.didMove(to: view)
    
        #if os(macOS)
        
        let options = [NSTrackingArea.Options.mouseMoved, NSTrackingArea.Options.activeInKeyWindow] as NSTrackingArea.Options
        let trackingArea = NSTrackingArea(rect:view.frame,options:options,owner:self,userInfo:nil)
        view.addTrackingArea(trackingArea)
        
        #endif                
    }

    override open func willMove(from view: SKView) {
        super.willMove(from: view)
        
        #if os(macOS)
        for trackingArea in view.trackingAreas {
            view.removeTrackingArea(trackingArea)
        }
        #endif
    }
    
    #if os(macOS)
    
    override open func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        
        for node in self.currentNodes {
            node.onMouseDown()
        }
    }
    
    override open func mouseDragged(with event: NSEvent) {
        super.mouseDragged(with: event)
  
        let location = event.location(in: self)
        let nodes = self.nodes(at: location)
        for node in self.currentNodes {
            let isTracking = nodes.contains(node)
            node.onMouseDrag(isTracking: isTracking)
        }
    }
    
    override open func mouseMoved(with event: NSEvent) {
        super.mouseMoved(with: event)
                        
        let location = event.location(in: self)
        let nodes = self.nodes(at: location)

        for node in self.currentNodes {
            if nodes.contains(node) == false {
                node.onMouseExit()
            }
        }
                
        self.currentNodes = nodes.filter({ $0 is MouseDeviceInteractable }) as? [MouseDeviceInteractable] ?? []

        for node in self.currentNodes {
            node.onMouseEnter()
        }
    }
    
    override open func mouseUp(with event: NSEvent) {
        super.mouseUp(with: event)
        
        let location = event.location(in: self)
        let nodes = self.nodes(at: location)
        
        for node in self.currentNodes {
            if nodes.contains(node) {
                node.onMouseUp()
            } else {
                mouseMoved(with: event)
            }            
        }
    }
    
    #endif
        
    private class DummyNode: SKSpriteNode & MouseDeviceInteractable {
        func onMouseEnter() {}
        
        func onMouseDrag(isTracking: Bool) {}
        
        func onMouseExit() {}
        
        func onMouseDown() {}
        
        func onMouseUp() {}
        
        init() {
            super.init(texture: nil, color: .clear, size: .zero)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError()
        }
    }
}
