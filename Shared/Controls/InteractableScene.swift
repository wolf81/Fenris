//
//  InteractableScene.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 13/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import SpriteKit

open class InteractableScene: SKScene {
    private var highlightedNodes = Set<SKNode>()
    
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
                
        NotificationCenter.default.addObserver(self, selector: #selector(updateForButtonNodeDidChangeStateNotification(_:)), name: Constants.buttonNodeDidChangeStateNotification, object: nil)
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
        
        let location = event.location(in: self)
        let nodes = self.nodes(at: location)

        for node in nodes {
            if let selectable = node as? Selectable {
                selectable.isSelected = true
            }
        }
    }
    
    override open func mouseDragged(with event: NSEvent) {
        super.mouseDragged(with: event)
        
        let location = event.location(in: self)
        let locationNodes = self.nodes(at: location)

//        print("1: nodes: \(self.highlightedNodes)")

        let removedNodes = self.highlightedNodes.filter({ locationNodes.contains($0) == false })
        let addedNodes = locationNodes.filter({ self.highlightedNodes.contains($0) == false })
        for node in removedNodes {
            if let selectableNode = node as? Selectable {
                selectableNode.isSelected = false
            } else {
                if let highlightableNode = node as? Highlightable {
                    highlightableNode.isHighlighted = false
                }
            }
            self.highlightedNodes.remove(node)
        }
        
        for node in addedNodes {
            if let selectable = node as? Selectable {
                selectable.isSelected = true
                self.highlightedNodes.insert(node)
            }
        }
//        print("2: nodes: \(self.highlightedNodes)")
    }
    
    override open func mouseMoved(with event: NSEvent) {
        super.mouseMoved(with: event)
                        
        let location = event.location(in: self)
        let locationNodes = self.nodes(at: location)

//        print("1: nodes: \(self.highlightedNodes)")

        let removedNodes = self.highlightedNodes.filter({ locationNodes.contains($0) == false })
        let addedNodes = locationNodes.filter({ self.highlightedNodes.contains($0) == false })
        for node in removedNodes {
            (node as? Highlightable)?.isHighlighted = false
            self.highlightedNodes.remove(node)
        }
        for node in addedNodes {
            if let highlightable = node as? Highlightable {
                highlightable.isHighlighted = true
                self.highlightedNodes.insert(node)
            }
        }
//        print("2: nodes: \(self.highlightedNodes)")
    }
    
    override open func mouseUp(with event: NSEvent) {
        super.mouseUp(with: event)
        
        let location = event.location(in: self)
        let nodes = self.nodes(at: location)
        
        for node in nodes {
            if let selectable = node as? Selectable {
                selectable.isSelected = false
            }
        }
    }
    
    #endif
    
    @objc private func updateForButtonNodeDidChangeStateNotification(_ notification: Notification) {
        let button = notification.userInfo![Constants.buttonNodeUserInfoKey] as! ButtonNode
        if button.isSelected == false && button.isHighlighted == false {
            self.highlightedNodes.remove(button)
        }
    }
}
