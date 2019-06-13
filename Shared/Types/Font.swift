//
//  Font.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 03/08/2018.
//  Copyright © 2018 Wolftrail. All rights reserved.
//

import Foundation
import CoreGraphics

#if os(macOS)
import Cocoa
public typealias Font = NSFont
#endif

#if os(iOS) || os(tvOS)
import UIKit
public typealias Font = UIFont
#endif

extension Font {
    var maxHeight: CGFloat {
        return self.ascender + abs(self.descender)
    }
}

