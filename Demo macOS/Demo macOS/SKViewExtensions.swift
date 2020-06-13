//
//  SKViewExtensions.swift
//  Demo macOS
//
//  Created by Wolfgang Schreurs on 13/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import SpriteKit

extension SKView {
    open override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        
        self.window?.acceptsMouseMovedEvents = true
    }
}
