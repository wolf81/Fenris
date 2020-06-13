//
//  CustomStringConvertibleExtensions.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 12/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import Foundation

extension CustomStringConvertible {
    public var description: String {
        var description: String = "\(type(of: self))("
        
        let selfMirror = Mirror(reflecting: self)
        
        for child in selfMirror.children {
            if let propertyName = child.label {
                description += "\(propertyName): \(child.value), "
            }
        }
        
        description += "<\(Unmanaged.passUnretained(self as AnyObject).toOpaque())>)"
        
        return description
    }
}
