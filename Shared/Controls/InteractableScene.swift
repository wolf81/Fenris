//
//  InteractableScene.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 13/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import SpriteKit

open class InteractableScene: SKScene {
    private var currentNodes: [DeviceInteractable] = []
    
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
            node.onDown()
        }
    }
    
    override open func mouseDragged(with event: NSEvent) {
        super.mouseDragged(with: event)
  
        let location = event.location(in: self)
        let nodes = self.nodes(at: location)
        for node in self.currentNodes {
            let isTracking = nodes.contains(node)
            node.onDrag(isTracking: isTracking)
        }
    }
    
    override open func mouseMoved(with event: NSEvent) {
        super.mouseMoved(with: event)
                        
        let location = event.location(in: self)
        let nodes = self.nodes(at: location)

        for node in self.currentNodes {
            if nodes.contains(node) == false {
                node.onExit()
            }
        }
                
        self.currentNodes = nodes.filter({ $0 is DeviceInteractable }) as? [DeviceInteractable] ?? []

        for node in self.currentNodes {
            node.onEnter()
        }
    }
            
    override open func mouseUp(with event: NSEvent) {
        super.mouseUp(with: event)
        
        let location = event.location(in: self)
        let nodes = self.nodes(at: location)
        
        for node in self.currentNodes {
            if nodes.contains(node) {
                node.onUp()
            } else {
                mouseMoved(with: event)
            }            
        }
    }

    func getInteractableChildNodes(for parent: SKNode) -> [DeviceInteractable] {
        var nodes: [DeviceInteractable] = []
        
        if let highlightable = parent as? DeviceInteractable, highlightable.isEnabled {
            nodes.append(highlightable)
        }
        
        for node in parent.children {
            let childNodes = getInteractableChildNodes(for: node)
            nodes.append(contentsOf: childNodes)
        }
                
        return nodes
    }
            
    open override func keyDown(with event: NSEvent) {
        
    }
    
    open override func keyUp(with event: NSEvent) {
        print(event.keyCode)

        var interactableNodes = getInteractableChildNodes(for: self)
        interactableNodes = interactableNodes.sorted { (h1, h2) -> Bool in
            let p1 = h1.convert(h1.position, to: self)
            let p2 = h2.convert(h1.position, to: self)
            
            if p1.y == p2.y {
                return p1.x < p2.x
            }

            return p1.y > p2.y
        }

        if self.currentNodes.count == 0 {
            if let node = interactableNodes.first {
                self.currentNodes.append(node)
            }
        }
        
        while self.currentNodes.count > 1 {
            self.currentNodes = self.currentNodes.dropLast()
        }

        let node = interactableNodes.first(where: { $0 == self.currentNodes[0] })
        node?.onEnter()
        print("node: \(node)")        
        
        // create a list of highlightable nodes
        // => if highlightable nodes contain highlightable children (scroller), go to child instead?
        // list should be sorted by position
        // could create some kind of virtual grid for this purpose

        // on key press:
        // look for highlighted node
        
        switch event.keyCode {
        case 0  /* a */:
            if var nodeIdx = interactableNodes.firstIndex(where: { $0 == self.currentNodes[0] }) {
                nodeIdx = (nodeIdx + 1) % interactableNodes.count
                
                for node in self.currentNodes {
                    node.onExit()
                }
                self.currentNodes.removeAll()

                let nextNode = interactableNodes[nodeIdx]
                nextNode.onEnter()
                self.currentNodes.append(nextNode)
            }
        case 1  /* s */: break
        case 2  /* d */: break
        case 13 /* w */: break
        case 49 /* space */:
            if let node = self.currentNodes.first {
                node.onDown()
                node.onUp()
            }
        default: break
        }
    }
    
    #endif
}

