//
//  MenuBuilder.Menu.Item.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 16/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import Foundation
import SpriteKit

/// Objects conforming to the Item protocol can be added to the menu.
public protocol MenuItem: class {
    
    /// Construct a node based on this item and some parameters.
    ///
    /// - Parameters:
    ///   - size: The size of the node.
    ///   - font: A font to use inside labels in the node.
    /// - Returns: A menu item node.
    func getNode(size: CGSize, font: Font) -> MenuItemNode
}

/// Fixed space items don't display any control, just empty space.
class FixedSpaceItem: MenuItem {
    public init() {}
    
    public func getNode(size: CGSize, font: Font) -> MenuItemNode {
        return FixedSpaceNode(size: size, item: self)
    }
}

/// A label with some text.
public class LabelItem: NSObject & MenuItem {
    @objc public dynamic var title: String
    
    public init(title: String) {
        self.title = title
        
        super.init()
    }
    
    public func getNode(size: CGSize, font: Font) -> MenuItemNode {
        return LabelNode(size: size, item: self, font: font)
    }
}

/// A button with some text.
public class ButtonItem: NSObject & MenuItem {
    @objc dynamic var title: String
    
    private let onClickBlock: () -> Void

    public init(title: String, onClick: @escaping () -> Void) {
        self.title = title
        self.onClickBlock = onClick
        
        super.init()
    }
    
    public func getNode(size: CGSize, font: Font) -> MenuItemNode {
        return ButtonNode(size: size, item: self, font: font)
    }
}

/// An on/off toggle.
public class ToggleItem: NSObject & MenuItem {
    @objc dynamic var isEnabled: Bool {
        didSet {
            if onValueChangeBlock(self.isEnabled) == false {
                self.isEnabled = oldValue
            }
        }
    }
    
    private let onValueChangeBlock: (Bool) -> Bool
    
    public init(enabled: Bool, onValueChange: @escaping (Bool) -> Bool) {
        self.isEnabled = enabled
        self.onValueChangeBlock = onValueChange
        
        super.init()
    }
    
    public func getNode(size: CGSize, font: Font) -> MenuItemNode {
        return ToggleNode(size: size, item: self, font: font)
    }
}

/// A chooser with a list of string values.
public class TextChooserItem: NSObject & MenuItem {
    let values: [String]
    
    @objc dynamic var selectedValueIdx: Int {
        didSet {
            if onValueChangeBlock(self.selectedValueIdx) == false {
                self.selectedValueIdx = oldValue
            }
        }
    }
    
    private let onValueChangeBlock: (Int) -> Bool
    
    public init(values: [String], selectedValueIdx: Int, onValueChange: @escaping (Int) -> Bool) {
        assert(values.count > 0, "The values array should contain at least 1 value")
        
        self.values = values
        self.selectedValueIdx = (0 ..< values.count).contains(selectedValueIdx) ? selectedValueIdx : 0
        self.onValueChangeBlock = onValueChange
        
        super.init()
    }
    
    public func getNode(size: CGSize, font: Font) -> MenuItemNode {
        return TextChooserNode(size: size, item: self, font: font)
    }
}

/// A chooser with a list of integer values.
public class NumberChooserItem: NSObject & MenuItem {
    let range: ClosedRange<Int>
    
    @objc dynamic var selectedValue: Int {
        didSet {
            if onValueChangeBlock(self.selectedValue) == false {
                self.selectedValue = oldValue
            }
        }
    }
    
    private let onValueChangeBlock: (Int) -> Bool
    
    public init(range: ClosedRange<Int>, selectedValue: Int, onValueChange: @escaping (Int) -> Bool) {
        assert((range.upperBound - range.lowerBound) > 0, "The range should have a distance of at least 1")
        
        self.range = range
        self.selectedValue = selectedValue
        self.onValueChangeBlock = onValueChange
        
        super.init()
    }
    
    public func getNode(size: CGSize, font: Font) -> MenuItemNode {
        return NumberChooserNode(size: size, item: self, font: font)
    }
}
