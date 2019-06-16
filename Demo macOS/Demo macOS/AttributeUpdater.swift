//
//  AttributeUpdater.swift
//  Demo macOS
//
//  Created by Wolfgang Schreurs on 16/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import Foundation

extension ViewController {
    class AttributeUpdater {
        private let total = 42
        
        public func update(strength: Int) -> Bool {
            return self.update(strength: strength, agility: self.agility, mind: self.mind)
        }
        
        public func update(agility: Int) -> Bool {
            return self.update(strength: self.strength, agility: agility, mind: self.mind)
        }
        
        public func update(mind: Int) -> Bool {
            return self.update(strength: self.strength, agility: self.agility, mind: mind)
        }
        
        private func update(strength: Int, agility: Int, mind: Int) -> Bool {
            let pointsRemaining = self.total - strength - agility - mind
            let success = pointsRemaining >= 0
            if success {
                self.strength = strength
                self.agility = agility
                self.mind = mind
            }
            return success
        }
        
        private(set) var strength: Int {
            didSet {
                self.pointsRemaining = self.total - self.strength - self.agility - self.mind
            }
        }
        
        private(set) var agility: Int {
            didSet {
                self.pointsRemaining = self.total - self.strength - self.agility - self.mind
            }
        }
        
        private(set) var mind: Int {
            didSet {
                self.pointsRemaining = self.total - self.strength - self.agility - self.mind
            }
        }
        
        private(set) var pointsRemaining: Int = 0 {
            didSet {
                pointsRemainingUpdateBlock(self.pointsRemaining)
            }
        }
        
        private let pointsRemainingUpdateBlock: (Int) -> Void
        
        init(strength: Int, agility: Int, mind: Int, onPointsRemainingUpdated: @escaping (Int) -> Void) {
            self.strength = strength
            self.agility = agility
            self.mind = mind
            self.pointsRemaining = self.total - self.strength - self.agility - self.mind
            self.pointsRemainingUpdateBlock = onPointsRemainingUpdated
        }
    }
}
