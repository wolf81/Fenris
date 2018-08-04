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
    var configuration: MenuNodeConfiguration { get }
}

// MARK: - Toggle

public class Toggle: MenuOption {
    public var configuration: MenuNodeConfiguration
    
    public var title: String
    public var checked: Bool {
        didSet(newValue) {
            valueChanged(newValue)
        }
    }
    public var valueChanged: ((Bool) -> Void)
    
    public init(title: String, value: Bool, valueChanged: @escaping ((Bool) -> Void)) {
        self.title = title
        self.checked = value
        self.valueChanged = valueChanged
        
        self.configuration = MenuNodeConfiguration()
    }
}

// MARK: - Button

public class Button: MenuOption {
    public var configuration: MenuNodeConfiguration
    
    public var title: String
    public var selected: (() -> Void)
    
    public init(title: String, selected: @escaping (() -> Void)) {
        self.title = title
        self.selected = selected
        
        self.configuration = MenuNodeConfiguration()
    }
    
    convenience internal init(title: String, configuration: MenuNodeConfiguration) {
        self.init(title: title, selected: {})
        
        self.configuration = configuration
    }
}

// MARK: - Chooser

public class Chooser: MenuOption {
    public var configuration: MenuNodeConfiguration
    
    public var title: String
    public var values: [String]
    public var selectedIndex: Int {
        didSet {
            self.valueChanged(self.value)
        }
    }
    public var valueChanged: ((String) -> Void)
    
    public var value: String {
        return self.values[self.selectedIndex]
    }
    
    public init(title: String, values: [String], selectedValue: String, valueChanged: @escaping ((String) -> Void)) {
        self.title = title
        self.values = values
        self.selectedIndex = values.index(of: selectedValue) ?? 0
        self.valueChanged = valueChanged
        
        self.configuration = MenuNodeConfiguration()
    }
    
    func selectNextValue() {
        if self.selectedIndex + 1 > (self.values.count - 1) {
            self.selectedIndex = 0
        } else {
            self.selectedIndex += 1
        }
    }    
}
