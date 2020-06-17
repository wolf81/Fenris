//
//  SKTextureExtensions.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 17/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import SpriteKit

extension SKTexture {
    internal static func texture(named imageName: String, fromBundle bundle: Bundle) -> SKTexture {
        let image: NSImage = bundle.image(forResource: imageName)!
        return SKTexture(image: image)
    }
}
