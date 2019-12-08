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

public typealias ClickBlock = () -> Void

public typealias ValueChangeBlock<T> = (T) -> Void

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

public protocol MenuFooterContainable where Self: MenuItem {
    
}

// MARK: - FixedSpaceItem

/// Fixed space items don't display any control, just empty space.
public class FixedSpaceItem: MenuItem & MenuFooterContainable {
    public init() {}
    
    public func getNode(size: CGSize, font: Font) -> MenuItemNode {
        return FixedSpaceNode(size: size, item: self)
    }
}

// MARK: - LabelItem

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

// MARK: - ButtonItem

/// A button with some text.
public class ButtonItem: NSObject & MenuItem & MenuFooterContainable {
    @objc dynamic var title: String
    
    public var onClick: ClickBlock?
    
    public init(title: String, onClick: (ClickBlock)? = nil) {
        self.title = title
        self.onClick = onClick
        
        super.init()
    }
    
    public func getNode(size: CGSize, font: Font) -> MenuItemNode {
        return ButtonNode(size: size, item: self, font: font)
    }
}

// MARK: - ToggleItem

/// An on/off toggle.
public class ToggleItem: NSObject & MenuItem {
    public var onValidate: ValidateBlock<Bool>? = nil

    public var onValueChanged: ValueChangeBlock<Bool>? = nil

    @objc dynamic var isEnabled: Bool {
        didSet {
            if onValidate?(self.isEnabled) == false { 
                self.isEnabled = oldValue
            }
        }
    }
    
    public init(enabled: Bool, onValueChanged: (ValueChangeBlock<Bool>)? = nil) {
        self.isEnabled = enabled
        self.onValueChanged = onValueChanged
        
        super.init()
    }
    
    public func getNode(size: CGSize, font: Font) -> MenuItemNode {
        return ToggleNode(size: size, item: self, font: font)
    }
}

// MARK: - TextChooserItem

/// A chooser with a list of string values.
public class TextChooserItem: NSObject & MenuItem {
    public var onValidate: ValidateBlock<Int>? = nil

    public var onValueChanged: ValueChangeBlock<String>? = nil
    
    public var values: [String] {
        didSet {
            self.selectedValueIdx = constrain(value: self.selectedValueIdx, to: (0 ..< self.values.count))
        }
    }
    
    @objc dynamic var selectedValueIdx: Int {
        didSet {
            if onValidate?(self.selectedValueIdx) == false {
                self.selectedValueIdx = oldValue
            }
        }
    }
    
    public init(values: [String], selectedValueIdx: Int, onValueChanged: (ValueChangeBlock<String>)? = nil) {
        // TODO: throw error if the values array doesn't contain at least 1 item
        self.values = values
        self.selectedValueIdx = constrain(value: selectedValueIdx, to: (0 ..< values.count))
        self.onValueChanged = onValueChanged
        
        super.init()
    }
    
    public func getNode(size: CGSize, font: Font) -> MenuItemNode {
        return TextChooserNode(size: size, item: self, font: font)
    }
}

// MARK: - NumberChooserItem

/// A chooser with a list of integer values.
public class NumberChooserItem: NSObject & MenuItem {
    public var onValidate: ValidateBlock<Int>? = nil

    public var onValueChanged: ValueChangeBlock<Int>? = nil

    public var range: ClosedRange<Int> {
        didSet {
            self.selectedValue = constrain(value: self.selectedValue, to: (self.range.lowerBound ..< self.range.upperBound + 1))
        }
    }
    
    @objc dynamic var selectedValue: Int {
        didSet {
            if onValidate?(self.selectedValue) == false {
                self.selectedValue = oldValue
            }
        }
    }
    
    public init(range: ClosedRange<Int>, selectedValue: Int, onValueChanged: (ValueChangeBlock<Int>)? = nil) {
        // TODO: throw error if the range isn't at least of length 1
        self.range = range
        self.selectedValue = constrain(value: selectedValue, to: (range.lowerBound ..< (range.upperBound + 1)))
        self.onValueChanged = onValueChanged
        
        super.init()
    }
    
    public func getNode(size: CGSize, font: Font) -> MenuItemNode {
        return NumberChooserNode(size: size, item: self, font: font)
    }
}
