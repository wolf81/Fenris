//
//  MenuOption.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 01/08/2018.
//  Copyright © 2018 Wolftrail. All rights reserved.
//

import Foundation

public protocol MenuOption: class {
    var title: String { get }
}

// MARK: - Label

public class Label: MenuOption {
    public var title: String
    public var selected: (() -> Void)

    public init(title: String, selected: @escaping (() -> Void)) {
        self.title = title
        self.selected = selected
    }
}

// MARK: - Toggle

public class Toggle: MenuOption {
    public var title: String
    public var value: Bool
    public var valueChanged: ((Bool) -> Void)
    
    public init(title: String, value: Bool, valueChanged: @escaping ((Bool) -> Void)) {
        self.title = title
        self.value = value
        self.valueChanged = valueChanged
    }
}

// MARK: - NumberPicker

public class NumberPicker: MenuOption {
    public var title: String
    public var range: Range<Int>
    public var value: Int
    public var valueChanged: ((Int) -> Void)
    
    public init(title: String, range: Range<Int>, value: Int, valueChanged: @escaping ((Int) -> Void)) {
        self.title = title
        self.range = range
        self.value = value
        self.valueChanged = valueChanged
    }
}
