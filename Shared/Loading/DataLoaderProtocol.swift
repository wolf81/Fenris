//
//  DataLoaderProtocol.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 17/04/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import Foundation

/// The DataLoaderProtocol is used for the loading scene to update loading progress and to notify when loading is completed.
public protocol DataLoaderProtocol {    
    func loadData(progress: @escaping (Float) -> ())
    
    func loadDataFinished()
}
