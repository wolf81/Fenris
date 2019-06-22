//
//  AttributeUpdater.swift
//  Demo macOS
//
//  Created by Wolfgang Schreurs on 16/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import Foundation

class AttributeUpdater {
    private let total = 42
    
    public func update(strength: Int) -> Bool {
        return self.update(strength: strength, dexterity: self.dexterity, mind: self.mind)
    }
    
    public func update(dexterity: Int) -> Bool {
        return self.update(strength: self.strength, dexterity: dexterity, mind: self.mind)
    }
    
    public func update(mind: Int) -> Bool {
        return self.update(strength: self.strength, dexterity: self.dexterity, mind: mind)
    }
    
    private func update(strength: Int, dexterity: Int, mind: Int) -> Bool {
        let pointsRemaining = self.total - strength - dexterity - mind
        let success = pointsRemaining >= 0
        if success {
            self.strength = strength
            self.dexterity = dexterity
            self.mind = mind
        }
        return success
    }
    
    private(set) var strength: Int {
        didSet {
            self.pointsRemaining = self.total - self.strength - self.dexterity - self.mind
        }
    }
    
    private(set) var dexterity: Int {
        didSet {
            self.pointsRemaining = self.total - self.strength - self.dexterity - self.mind
        }
    }
    
    private(set) var mind: Int {
        didSet {
            self.pointsRemaining = self.total - self.strength - self.dexterity - self.mind
        }
    }
    
    private(set) var pointsRemaining: Int = 0 {
        didSet {
            pointsRemainingUpdateBlock(self.pointsRemaining)
        }
    }
    
    private let pointsRemainingUpdateBlock: (Int) -> Void
    
    init(strength: Int, dexterity: Int, mind: Int, onPointsRemainingUpdated: @escaping (Int) -> Void) {
        self.strength = strength
        self.dexterity = dexterity
        self.mind = mind
        self.pointsRemaining = self.total - self.strength - self.dexterity - self.mind
        self.pointsRemainingUpdateBlock = onPointsRemainingUpdated
    }
}
