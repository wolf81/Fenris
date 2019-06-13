//
//  MenuItem.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 13/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import Foundation

public protocol MenuItem {
    var title: String { get }
}

// E.g. "Quit"
public class ButtonMenuItem: MenuItem {
    public let title: String
    
    required public init(title: String) {
        self.title = title
    }
}

// E.g. "Profession: <[ Fighter, Mage, Priest ]>"
public class ChooserMenuItem: MenuItem {
    public var title: String
    
    let values: [String]
    
    var selectedValueIdx: Int
    
    public required init(title: String, values: [String], selectedValueIdx: Int) {
        self.title = title
        self.values = values
        self.selectedValueIdx = selectedValueIdx
    }
}

// E.g. "Music: <[ On, Off ]>"
public class ToggleMenuItem: MenuItem {
    public let title: String
    
    private var isEnabled: Bool
    
    required public init(title: String, enabled: Bool) {
        self.title = title
        self.isEnabled = enabled
    }
}

// E.g. "Volume: <[ 0 ... 10 ]>"
public class RangeMenuItem: MenuItem {
    public let title: String
    
    private let range: Range<Int>
    
    private var selectedValue: Int
    
    required public init(title: String, range: Range<Int>, selectedValue: Int) {
        self.title = title
        self.range = range
        self.selectedValue = selectedValue
    }
}
