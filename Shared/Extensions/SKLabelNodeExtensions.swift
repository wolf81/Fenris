//
//  SKLabelNodeExtensions.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 03/08/2018.
//  Copyright © 2018 Wolftrail. All rights reserved.
//

import SpriteKit

extension SKLabelNode {
    var font: Font? {
        get {
            guard let fontName = self.fontName else {
                return nil
            }
            
            do {
                let font = try Font(name: fontName, size: self.fontSize)
                return font
            } catch let error {
                print("[ERROR] \(error.localizedDescription)")
            }
            return nil
        }
        set(newValue) {
            // TODO: think if this is what we really want to do if font is nil
            self.fontName = newValue?.name
            self.fontSize = newValue?.size ?? 0
        }
    }
}
