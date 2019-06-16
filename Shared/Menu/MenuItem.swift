//
//  MenuBuilder.Menu.Item.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 16/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import Foundation
import SpriteKit

/// Use the validate block whenever a value of a menu item is set. If the result of the validate
/// block is false, the value should be reset to the old value.
public typealias ValidateBlock<T> = (T) -> Bool

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
    public var onValidate: ValidateBlock<Bool>? = nil

    @objc dynamic var isEnabled: Bool {
        didSet {
            if onValidate?(self.isEnabled) == false {
                self.isEnabled = oldValue
            }
        }
    }
    
    public init(enabled: Bool) {
        self.isEnabled = enabled
        
        super.init()
    }
    
    public func getNode(size: CGSize, font: Font) -> MenuItemNode {
        return ToggleNode(size: size, item: self, font: font)
    }
}

/// A chooser with a list of string values.
public class TextChooserItem: NSObject & MenuItem {
    public var onValidate: ValidateBlock<Int>? = nil

    let values: [String]
    
    @objc dynamic var selectedValueIdx: Int {
        didSet {
            if onValidate?(self.selectedValueIdx) == false {
                self.selectedValueIdx = oldValue
            }
        }
    }
    
    public init(values: [String], selectedValueIdx: Int) {
        assert(values.count > 0, "The values array should contain at least 1 value")
        
        self.values = values
        self.selectedValueIdx = (0 ..< values.count).contains(selectedValueIdx) ? selectedValueIdx : 0
        
        super.init()
    }
    
    public func getNode(size: CGSize, font: Font) -> MenuItemNode {
        return TextChooserNode(size: size, item: self, font: font)
    }
}

/// A chooser with a list of integer values.
public class NumberChooserItem: NSObject & MenuItem {
    public var onValidate: ValidateBlock<Int>? = nil

    let range: ClosedRange<Int>
    
    @objc dynamic var selectedValue: Int {
        didSet {
            if onValidate?(self.selectedValue) == false {
                self.selectedValue = oldValue
            }
        }
    }
    
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
