//
//  ViewController.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 01/08/2018.
//  Copyright © 2018 Wolftrail. All rights reserved.
//

#if os(macOS)
import Cocoa
public typealias ViewController = NSViewController
#endif

#if os(iOS)
import UIKit
public typealias ViewController = UIViewController
#endif
