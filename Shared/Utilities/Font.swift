//
//  Font.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 03/08/2018.
//  Copyright © 2018 Wolftrail. All rights reserved.
//

import Foundation

#if os(macOS)
import Cocoa
#endif

#if os(iOS)
import UIKit
#endif

enum FontError: LocalizedError {
    case invalidFont(String, CGFloat)
    
    var errorDescription: String? {
        switch self {
        case .invalidFont(let name, let size):
            return "Could not create font with name \(name) and size: \(size)"
        }
    }
}

class Font {
    private(set) var name: String
    private(set) var size: CGFloat
    
    private(set) var ascender: CGFloat
    private(set) var descender: CGFloat
    private(set) var xHeight: CGFloat
    
    var maxHeight: CGFloat {
        return self.ascender + fabs(self.descender)
    }
    
    init(name: String, size: CGFloat) throws {
        // check if font can be created, otherwise crash
        // set ascender, descender, etc...
        #if os(macOS)
        guard let font = NSFont(name: name, size: size) else {
            throw FontError.invalidFont(name, size)
        }
        
        self.ascender = font.ascender
        self.descender = font.descender
        self.xHeight = font.xHeight
        #endif
     
        self.name = name
        self.size = size

    }
}
