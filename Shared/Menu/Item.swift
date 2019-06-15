//
//  Item.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 15/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import Foundation
import SpriteKit

/* Objects conforming to the Item protocol can be added to the menu */
public protocol Item: class {
    func getNode(size: CGSize, font: Font) -> SKShapeNode
}

public class FixedSpaceItem: Item {
    public init() {}
    
    public func getNode(size: CGSize, font: Font) -> SKShapeNode {
        return FlexibleSpaceNode(size: size)
    }
}

public class LabelItem: NSObject & Item {
    @objc dynamic var title: String
    
    public init(title: String) {
        self.title = title
        
        super.init()
    }
    
    public func getNode(size: CGSize, font: Font) -> SKShapeNode {
        return LabelNode(size: size, item: self, font: font)
    }
}

public class ButtonItem: NSObject & Item {
    @objc dynamic var title: String
    
    public init(title: String) {
        self.title = title
        
        super.init()
    }
    
    public func getNode(size: CGSize, font: Font) -> SKShapeNode {
        return ButtonNode(size: size, item: self, font: font)
    }
}

public class ToggleItem: NSObject & Item {
    @objc dynamic var isEnabled: Bool
    
    public init(enabled: Bool) {
        self.isEnabled = enabled
        
        super.init()
    }
    
    public func getNode(size: CGSize, font: Font) -> SKShapeNode {
        return ToggleNode(size: size, item: self, font: font)
    }
}

public class TextChooserItem: NSObject & Item {
    let values: [String]
    
    @objc dynamic var selectedValue: String
    
    public init(values: [String], selectedValue: String) {
        assert(values.count > 0, "The values array should contain at least 1 value")
        self.values = values
        self.selectedValue = selectedValue
        
        super.init()
    }
    
    public func getNode(size: CGSize, font: Font) -> SKShapeNode {
        return TextChooserNode(size: size, item: self, font: font)
    }
}

public class NumberChooserItem: NSObject & Item {
    let range: ClosedRange<Int>
    
    @objc dynamic var selectedValue: Int
    
    public init(range: ClosedRange<Int>, selectedValue: Int) {
        assert((range.upperBound - range.lowerBound) > 0, "The range should have a distance of at least 1")
        
        self.range = range
        self.selectedValue = selectedValue
        
        super.init()
    }
    
    public func getNode(size: CGSize, font: Font) -> SKShapeNode {
        return NumberChooserNode(size: size, item: self, font: font)
    }
}
