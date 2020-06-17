//
//  ControlState.h
//  Fenris
//
//  Created by Wolfgang Schreurs on 17/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef ControlState_h
#define ControlState_h

/*
public struct ControlState: OptionSet, Hashable {
    public let rawValue: UInt8
    
    static let `default` = ControlState(rawValue: 1 << 0)
    static let highlighted = ControlState(rawValue: 1 << 1)
    static let selected = ControlState(rawValue: 1 << 2)
    static let disabled = ControlState(rawValue: 1 << 3)
    
    public init(rawValue: UInt8) {
        self.rawValue = rawValue
    }
}
*/
    
typedef NS_OPTIONS(NSInteger, ControlState) {
    ControlStateDefault = 1 << 0,
    ControlStateHighlighted = 1 << 1,
    ControlStateSelected = 1 << 2,
    ControlStateDisabled = 1 << 3,
};

#endif /* ControlState_h */
