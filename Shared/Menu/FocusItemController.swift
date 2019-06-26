//
//  FocusItemController.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 23/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

/// A delegate that informs on focus item changes.
protocol FocusItemControllerDelegate: class {
    func focusItemController(_ controller: FocusItemController, didChangeFocusedItem focusItem: FocusItem?)
}

/// The FocusItemController maintains a 2-dimensional list of items that are focusable in the menu.
/// Within this list it's possible to navigate up, down, left or right to focused items. A delegate
/// informs on focused item change.
class FocusItemController {
    typealias FocusSection = [FocusItem]
    
    private var sections: [FocusSection] = []
    
    private var focusedItemIdx: IndexPath? {
        didSet {
            self.delegate?.focusItemController(self, didChangeFocusedItem: self.focusedItem)
        }
    }
    
    /// The amount of focused items maintained by the FocusItemController.
    var itemCount: Int {
        return self.sections.reduce(0) { $0 + $1.count }
    }
    
    /// A delegate that will receive notifications when changes occur in the FocusItemController.
    weak var delegate: FocusItemControllerDelegate?
    
    /// The item that is currently in focus.
    var focusedItem: FocusItem? {
        guard let idx = self.focusedItemIdx else { return nil }
        return self.sections[idx.section][idx.item]
    }
    
    /// The constructor.
    ///
    /// - Parameters:
    ///   - menuRowNodes: A MenuRowNode list for which we want to keep focus.
    ///   - parentNode: The node that maintains the MenuRowNode list.
    init(menuRowNodes: [MenuRowNode], parentNode: SKNode) {
        for menuRowNode in menuRowNodes {
            let interactableItems = menuRowNode.itemNodes.filter({ $0 is InputDeviceInteractable }) as! [InputDeviceInteractable]
            
            switch interactableItems.count {
            case 0: continue
            case 1:
                let focusItem = FocusItem(frame: menuRowNode.frame, interactableNode: interactableItems[0])
                self.sections.append(FocusSection([focusItem]))
                self.focusedItemIdx = IndexPath(item: 0, section: 0)
            default:
                var section = FocusSection()
                for interactableItem in interactableItems {
                    let origin = menuRowNode.convert(interactableItem.frame.origin, to: parentNode)
                    let size = interactableItem.frame.size
                    let focusItem = FocusItem(frame: CGRect(origin: origin, size: size), interactableNode: interactableItem)
                    section.append(focusItem)
                }
                self.sections.append(section)
                self.focusedItemIdx = IndexPath(item: 0, section: 0)
            }
        }
    }
    
    /// Change the focus to 1 item above the current focused item.
    ///
    /// - Returns: True if the focus was changed, otherwise false.
    @discardableResult
    public func focusUp() -> Bool {
        guard let idx = self.focusedItemIdx else { return false }
        
        let sectionCount = self.sections.count
        let range = (0 ..< sectionCount)
        let section = constrain(value: idx.section - 1, to: range)

        guard section != idx.section else { return false }
        
        self.focusedItemIdx = IndexPath(item: 0, section: section)
        
        return true
    }
    
    /// Change the focus to 1 item below the current focused item.
    ///
    /// - Returns: True if the focus was changed, otherwise false.
    @discardableResult
    public func focusDown() -> Bool {
        guard let idx = self.focusedItemIdx else { return false }

        let sectionCount = self.sections.count
        let range = (0 ..< sectionCount)
        let section = constrain(value: idx.section + 1, to: range)

        guard section != idx.section else { return false }
        
        self.focusedItemIdx = IndexPath(item: 0, section: section)
        
        return true
    }
    
    /// Change the focus to 1 item left of the current focused item.
    ///
    /// - Returns: True if the focus was changed, otherwise false.
    @discardableResult
    public func focusLeft() -> Bool {
        guard let idx = self.focusedItemIdx else { return false }
        
        let sectionItems = self.sections[idx.section]
        let range = (0 ..< sectionItems.count)
        let item = constrain(value: idx.item - 1, to: range)
        
        guard item != idx.item else { return false }
        
        self.focusedItemIdx = IndexPath(item: item, section: idx.section)
        
        return true
    }
    
    /// Change the focus to 1 item right of the current focused item.
    ///
    /// - Returns: True if the focus was changed, otherwise false.
    @discardableResult
    public func focusRight() -> Bool {
        guard let idx = self.focusedItemIdx else { return false }

        let sectionItems = self.sections[idx.section]
        let range = (0 ..< sectionItems.count)
        let item = constrain(value: idx.item + 1, to: range)
        
        guard item != idx.item else { return false }
        
        self.focusedItemIdx = IndexPath(item: item, section: idx.section)
        
        return true
    }
    
    /// Try to focus the item at the current location, if such an item exists. Will set the focused
    /// node to nil if no such item could be found.
    ///
    /// - Parameter location: The location to focus on, provided an focusable item exist at the
    /// provided location
    /// - Returns: True if the focus was changed, otherwise false.
    @discardableResult
    public func focusItem(at location: CGPoint) -> Bool {
        var focusItemIdx: IndexPath?
        
        for (sectionIdx, section) in self.sections.enumerated() {
            for (itemIdx, item) in section.enumerated() {
                if item.frame.contains(location) {
                    focusItemIdx = IndexPath(item: itemIdx, section: sectionIdx)
                    break
                }
            }
        }
        
        guard focusItemIdx != self.focusedItemIdx else { return false }

        self.focusedItemIdx = focusItemIdx
        
        return true
    }
}
