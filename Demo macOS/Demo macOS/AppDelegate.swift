//
//  AppDelegate.swift
//  Demo macOS
//
//  Created by Wolfgang Schreurs on 13/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//


import Cocoa
import Fenris
import SpriteKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        TextButtonNode.appearance.fontName = "Papyrus"
        TextButtonNode.appearance.fontSize = 22
        TextButtonNode.appearance.fontColor = SKColor.init(white: 0.95, alpha: 1)

        LabelNode.appearance.fontName = "Impact"
        LabelNode.appearance.fontSize = 24
        LabelNode.appearance.fontColor = SKColor.init(white: 0.95, alpha: 1)
        
        TextChooserNode.appearance.fontName = "Papyrus"
        TextChooserNode.appearance.fontSize = 24
        TextChooserNode.appearance.fontColor = .purple

        NumberChooserNode.appearance.fontName = "Papyrus"
        NumberChooserNode.appearance.fontSize = 24
        NumberChooserNode.appearance.fontColor = .yellow

        print(TextButtonNode.appearance)
        print(LabelNode.appearance)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationDidBecomeActive(_ notification: Notification) {
        
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}
