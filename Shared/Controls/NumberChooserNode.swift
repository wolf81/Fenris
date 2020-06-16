//
//  NumberChooserNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 16/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import Foundation

public class NumberChooserNode: ChooserNode<Int>  {
    init(size: CGSize, item: NumberChooserItem, font: Font) {
        super.init(values: [1], size: size)
    }

    public override init(values: [Int], size: CGSize) {
        super.init(values: values, size: size)
        
        self.name = "NumberChooserNode"

        self.isLoopValuesEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}


