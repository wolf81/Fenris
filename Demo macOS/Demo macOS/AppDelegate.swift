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
        
        LabelNode.appearance.fontName = "Impact"
        LabelNode.appearance.fontSize = 16
        LabelNode.appearance.fontColor = SKColor.red
        
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
