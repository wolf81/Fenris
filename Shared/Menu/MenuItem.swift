//
//  MenuItem.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 13/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import Foundation

public typealias ClickBlock = () -> Void
public typealias ValueChangedBlock<T> = (T) -> Bool

/// An item to be displayed in the menu. Every item at the very least has a title.
public protocol MenuItem {
    var title: String { get }
}

// MARK: - Concrete menu items
// For every menu item in short a comment is added on how the control will work
//
// The following conventions are used:
// [ ... ] The square brackets indicate a control
// < ... > The less-than and greater-than signs indicate the ability to scroll through a list
// - ... + The plus and minus sign indicate the ability to increment or decrement some number

// E.g. "[ Quit ]"
public class ButtonMenuItem: MenuItem {
    public let title: String
    
    private let onClick: ClickBlock
    
    public init(title: String, onClick: @escaping ClickBlock) {
        self.title = title
        self.onClick = onClick
    }
}

public class LabelMenuItem: NSObject, MenuItem {
    public let title: String
    
    @objc dynamic public var value: String {
        didSet {
            if self.value != oldValue {
                print("new value: \(self.value)")
            }
        }
    }

    public init(title: String, value: String) {
        self.title = title
        self.value = value
    }
}

// E.g. "Profession: <[ Fighter ]>"
public class ChooserMenuItem: NSObject, MenuItem {
    public let title: String
    
    let values: [String]
    
    @objc dynamic var selectedValueIdx: Int {
        didSet {
            print("newValue: \(self.selectedValueIdx)")
            if onValueChanged(self.values[self.selectedValueIdx]) == false {
                self.selectedValueIdx = oldValue
            }
        }
    }
    
    private let onValueChanged: ValueChangedBlock<String>
    
    public init(title: String, values: [String], selectedValueIdx: Int, onValueChanged: @escaping ValueChangedBlock<String>) {
        self.title = title
        self.values = values
        self.selectedValueIdx = selectedValueIdx
        self.onValueChanged = onValueChanged
    }
}

// E.g. "Music: <[ Off ]>"
public class ToggleMenuItem: NSObject, MenuItem {
    public let title: String
    
    @objc dynamic var isEnabled: Bool {
        didSet {
            if onValueChanged(self.isEnabled) == false {
                self.isEnabled = oldValue
            }
        }
    }
    
    let onValueChanged: ValueChangedBlock<Bool>
    
    public init(title: String, enabled: Bool, onValueChanged: @escaping ValueChangedBlock<Bool>) {
        self.title = title
        self.isEnabled = enabled
        self.onValueChanged = onValueChanged
    }
}

// E.g.: "Strength: -[ 10 ]+"
public class NumberChooserMenuItem: NSObject, MenuItem {
    public let title: String
    
    var range: ClosedRange<Int>

    @objc dynamic var selectedValue: Int {
        didSet {
            if onValueChanged(self.selectedValue) == false {
                self.selectedValue = oldValue
            }
        }
    }
    
    let onValueChanged: ValueChangedBlock<Int>
    
    public init(title: String, range: ClosedRange<Int>, selectedValue: Int, onValueChanged: @escaping ValueChangedBlock<Int>) {
        self.title = title
        self.range = range
        self.selectedValue = selectedValue
        self.onValueChanged = onValueChanged
    }
}
