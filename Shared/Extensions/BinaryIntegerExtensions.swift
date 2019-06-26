//
//  BinaryIntegerExtensions.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 26/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import Foundation

extension BinaryInteger {
    var binaryDescription: String {
        var binaryString = ""
        var internalNumber = self
        var counter = 0
        
        for _ in (1...self.bitWidth) {
            binaryString.insert(contentsOf: "\(internalNumber & 1)", at: binaryString.startIndex)
            internalNumber >>= 1
            counter += 1
            if counter % 4 == 0 {
                binaryString.insert(contentsOf: " ", at: binaryString.startIndex)
            }
        }
        
        return binaryString
    }
}
