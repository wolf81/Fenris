//
//  MenuBuilder.Menu.Item.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 16/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import Foundation
import SpriteKit

/* Objects conforming to the Item protocol can be added to the menu */
public protocol MenuItem: class {
    func getNode(size: CGSize, font: Font) -> MenuItemNode
}

class FixedSpaceItem: MenuItem {
    public init() {}
    
    public func getNode(size: CGSize, font: Font) -> MenuItemNode {
        return FixedSpaceNode(size: size, item: self)
    }
}

public class LabelItem: NSObject & MenuItem {
    @objc dynamic var title: String
    
    public init(title: String) {
        self.title = title
        
        super.init()
    }
    
    public func getNode(size: CGSize, font: Font) -> MenuItemNode {
        return LabelNode(size: size, item: self, font: font)
    }
}

public class ButtonItem: NSObject & MenuItem {
    @objc dynamic var title: String
    
    public init(title: String) {
        self.title = title
        
        super.init()
    }
    
    public func getNode(size: CGSize, font: Font) -> MenuItemNode {
        return ButtonNode(size: size, item: self, font: font)
    }
}

public class ToggleItem: NSObject & MenuItem {
    @objc dynamic var isEnabled: Bool
    
    public init(enabled: Bool) {
        self.isEnabled = enabled
        
        super.init()
    }
    
    public func getNode(size: CGSize, font: Font) -> MenuItemNode {
        return ToggleNode(size: size, item: self, font: font)
    }
}

public class TextChooserItem: NSObject & MenuItem {
    let values: [String]
    
    @objc dynamic var selectedValue: String
    
    public init(values: [String], selectedValue: String) {
        assert(values.count > 0, "The values array should contain at least 1 value")
        self.values = values
        self.selectedValue = selectedValue
        
        super.init()
    }
    
    public func getNode(size: CGSize, font: Font) -> MenuItemNode {
        return TextChooserNode(size: size, item: self, font: font)
    }
}

public class NumberChooserItem: NSObject & MenuItem {
    let range: ClosedRange<Int>
    
    @objc dynamic var selectedValue: Int
    
    public init(range: ClosedRange<Int>, selectedValue: Int) {
        assert((range.upperBound - range.lowerBound) > 0, "The range should have a distance of at least 1")
        
        self.range = range
        self.selectedValue = selectedValue
        
        super.init()
    }
    
    public func getNode(size: CGSize, font: Font) -> MenuItemNode {
        return NumberChooserNode(size: size, item: self, font: font)
    }
}
