//
//  DefaultMenuConfiguration.swift
//  Demo macOS
//
//  Created by Wolfgang Schreurs on 19/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import Fenris
import CoreGraphics

class DefaultMenuConfiguration: MenuConfiguration {
    var titleFont: Font { return Font(name: "Papyrus", size: 22)! }
    var labelFont: Font { return Font(name: "Papyrus", size: 18)! }
    var menuWidth: CGFloat { return 460 }
    var rowHeight: CGFloat { return 40 }
}
