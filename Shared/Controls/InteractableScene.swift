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
            if let highlightable = node as? Highlightable {
                highlightable.isHighlighted = highlightable.contains(location)
                
                self.highlightedNodes.insert(highlightable)
            }
        }
    }
    
    override open func mouseDragged(with event: NSEvent) {
        super.mouseDragged(with: event)
                
        let location = event.location(in: self)

        let nodes = self.highlightedNodes.filter({ $0.contains(location) == false })
        for node in nodes {
            (node as! Highlightable).isHighlighted = false
            self.highlightedNodes.remove(node)
        }
        
        for node in self.nodes(at: location) {
            if let highlightable = node as? Highlightable {
                highlightable.isHighlighted = highlightable.contains(location)
                
                self.highlightedNodes.insert(highlightable)
            }
        }
    }
    
    override open func mouseMoved(with event: NSEvent) {
        super.mouseMoved(with: event)
                
        let location = event.location(in: self)

        let nodes = self.highlightedNodes.filter({ $0.contains(location) == false })
        for node in nodes {
            (node as! Highlightable).isHighlighted = false
            self.highlightedNodes.remove(node)
        }
    }
    
    override open func mouseUp(with event: NSEvent) {
        super.mouseUp(with: event)
        
        let location = event.location(in: self)
        let nodes = self.nodes(at: location)

        for node in nodes {
            if let selectable = node as? Selectable {
                selectable.isSelected = selectable.contains(location)
                selectable.isHighlighted = false
            }
        }
    }
    
    #endif
}
