//
//  AppearanceProxy.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 16/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import SpriteKit

public protocol AppearanceProxy {
    static var appearance: Appearance { get }
}

public class Appearance: NSObject {
    override init() {
        self.fontSize = 32
        self.fontName = "HelveticaNeue-UltraLight"
        self.fontColor = .white
        self.highlightColor = .yellow
        
        super.init()
    }
    
    @objc dynamic public var fontName: String
    
    @objc dynamic public var fontColor: SKColor
    
    @objc dynamic public var fontSize: CGFloat
    
    @objc dynamic public var highlightColor: SKColor
}

extension LabelNode: AppearanceProxy {
    @objc dynamic public static let appearance = Appearance()
}

extension TextChooserNode: AppearanceProxy {
    @objc dynamic public static let appearance = Appearance()
}

extension NumberChooserNode: AppearanceProxy {
    @objc dynamic public static let appearance = Appearance()
}

extension ButtonNode: AppearanceProxy {
    @objc dynamic public static let appearance = Appearance()    
}
