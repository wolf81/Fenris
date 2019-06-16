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
    
    let onClick: ClickBlock

    public init(title: String, onClick: @escaping ClickBlock) {
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

// MARK: - TextChooserItem

/// A chooser with a list of string values.
public class TextChooserItem: NSObject & MenuItem {
    public var onValidate: ValidateBlock<Int>? = nil

    public var values: [String] {
        didSet {
            assertArray(self.values, minimumLength: 1)

            let range = (0 ..< values.count)
            switch self.selectedValueIdx {
            case _ where self.selectedValueIdx < range.lowerBound:
                self.selectedValueIdx = range.lowerBound
            case _ where self.selectedValueIdx > range.upperBound:
                self.selectedValueIdx = range.upperBound
            default:
                break
            }
        }
    }
    
    @objc dynamic var selectedValueIdx: Int {
        didSet {
            if onValidate?(self.selectedValueIdx) == false {
                self.selectedValueIdx = oldValue
            }
        }
    }
    
    public init(values: [String], selectedValueIdx: Int) {
        assertArray(values, minimumLength: 1)

        self.values = values
        self.selectedValueIdx = (0 ..< values.count).contains(selectedValueIdx) ? selectedValueIdx : 0
        
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

    public var range: ClosedRange<Int> {
        didSet {
            assertRange(self.range, minimumDistance: 1)
            
            switch self.range {
            case _ where self.selectedValue < range.lowerBound:
                self.selectedValue = range.lowerBound
            case _ where self.selectedValue > range.upperBound:
                self.selectedValue = range.upperBound
            default:
                break
            }
        }
    }
    
    @objc dynamic var selectedValue: Int {
        didSet {
            if onValidate?(self.selectedValue) == false {
                self.selectedValue = oldValue
            }
        }
    }
    
    public init(range: ClosedRange<Int>, selectedValue: Int) {
        assertRange(range, minimumDistance: 1)

        self.range = range
        self.selectedValue = selectedValue
        
        super.init()
    }
    
    public func getNode(size: CGSize, font: Font) -> MenuItemNode {
        return NumberChooserNode(size: size, item: self, font: font)
    }
}
