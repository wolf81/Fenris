//
//  MenuItem.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 13/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import Foundation

public typealias ClickBlock = () -> Void
public typealias ValueChangedBlock<T> = (T) -> Void

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
    
    required public init(title: String, onClick: @escaping ClickBlock) {
        self.title = title
        self.onClick = onClick
    }
}

// E.g. "Profession: <[ Fighter ]>"
public class ChooserMenuItem: MenuItem {
    public let title: String
    
    let values: [String]
    
    var selectedValueIdx: Int {
        didSet {
            onValueChanged(self.values[self.selectedValueIdx])
        }
    }
    
    private let onValueChanged: ValueChangedBlock<String>
    
    public required init(title: String, values: [String], selectedValueIdx: Int, onValueChanged: @escaping ValueChangedBlock<String>) {
        self.title = title
        self.values = values
        self.selectedValueIdx = selectedValueIdx
        self.onValueChanged = onValueChanged
    }
}

// E.g. "Music: <[ Off ]>"
public class ToggleMenuItem: MenuItem {
    public let title: String
    
    var isEnabled: Bool {
        didSet {
            onValueChanged(self.isEnabled)
        }
    }
    
    let onValueChanged: ValueChangedBlock<Bool>
    
    required public init(title: String, enabled: Bool, onValueChanged: @escaping ValueChangedBlock<Bool>) {
        self.title = title
        self.isEnabled = enabled
        self.onValueChanged = onValueChanged
    }
}

// E.g.: "Strength: -[ 10 ]+"
public class NumberChooserMenuItem: MenuItem {
    public let title: String
    
    var range: ClosedRange<Int>

    var selectedValue: Int {
        didSet {
            onValueChanged(self.selectedValue)
        }
    }
    
    let onValueChanged: ValueChangedBlock<Int>
    
    public required init(title: String, range: ClosedRange<Int>, selectedValue: Int, onValueChanged: @escaping ValueChangedBlock<Int>) {
        self.title = title
        self.range = range
        self.selectedValue = selectedValue
        self.onValueChanged = onValueChanged
    }
}
