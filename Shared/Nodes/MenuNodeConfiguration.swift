//
//  MenuNodeConfiguration.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 04/08/2018.
//  Copyright © 2018 Wolftrail. All rights reserved.
//

import CoreGraphics

public class MenuNodeConfiguration {
    
    /// An offset that can be used to place labels higher or lower within the node.
    var labelYOffset: CGFloat
    
    /// Whenever a node contains both a label and a control (e.g. a button or toggle),
    /// then this is the spacing used between these nodes.
    var spacing: CGFloat
    
    /// The height for a control.
    var height: CGFloat
    
    /// The font for a control.
    var font: Font
    
    public convenience init() {
        let font = try! Font(name: "Papyrus", size: 24)
        self.init(font: font, height: 42, spacing: 30, labelYOffset: 9)
    }
    
    /// Designated initializer to create a configuration.
    ///
    /// - Parameters:
    ///   - font: The font to be used inside the control.
    ///   - height: The height to be used for the control.
    ///   - spacing: The horizontal spacing to be used between 2 nodes in the control.
    ///   - labelYOffset: An y offset that can be used to place labels higher / lower.
    public init(font: Font, height: CGFloat, spacing: CGFloat, labelYOffset: CGFloat) {
        self.labelYOffset = labelYOffset
        self.spacing = spacing
        self.height = height
        self.font = font
    }
}
