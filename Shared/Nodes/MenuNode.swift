//
//  MenuNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 02/08/2018.
//  Copyright © 2018 Wolftrail. All rights reserved.
//

import SpriteKit

protocol MenuNode where Self: SKShapeNode {
    
    /// The maximum X value of the title label, used for positioning the node in the menu scene.
    var titleLabelMaxX: CGFloat { get }
    
    /// Spacing between the title label and the control, by default will be 30 pixels.
    var spacing: CGFloat { get }    
    
    /// Perform interaction on the menu node
    ///
    /// - Parameter location: The location where the node was hit by mouse or touch.
    func interact(location: CGPoint)
}

extension MenuNode where Self: SKShapeNode {
    var spacing: CGFloat {
        return 30
    }
    
    var titleYOffset: CGFloat {
        return -3
    }
}
