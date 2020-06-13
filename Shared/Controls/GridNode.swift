//
//  GridNode.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 12/06/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import SpriteKit

public class GridNode: SKSpriteNode {
    private let gridLayout: GridLayout
    
    public init(layout: GridLayout, size: CGSize) {
        self.gridLayout = layout
        
        super.init(texture: nil, color: .black, size: size)
        
        self.anchorPoint = CGPoint.zero
        
        updateGridSize()
        updateGridLayout()
    }
        
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    private func updateGridSize() {
        var remainingHeight: CGFloat = self.size.height
        var autoHeightCellCount: Int = 0
        for rowDefinition in self.gridLayout.rowDefinitions {
            if rowDefinition.isAutoSizing {
                autoHeightCellCount += 1
            } else {
                remainingHeight -= rowDefinition.height
            }
        }
        
        for rowDefinition in self.gridLayout.rowDefinitions {
            if rowDefinition.isAutoSizing {
                rowDefinition.height = floor(remainingHeight / CGFloat(autoHeightCellCount))
            }
        }
        
        var remainingWidth: CGFloat = self.size.width
        var autoWidthCellCount: Int = 0
        for columnDefinition in self.gridLayout.columnDefinitions {
            if columnDefinition.isAutoSizing {
                autoWidthCellCount += 1
            } else {
                remainingWidth -= columnDefinition.width
            }
        }
        
        for columnDefinition in self.gridLayout.columnDefinitions {
            if columnDefinition.isAutoSizing {
                columnDefinition.width = floor(remainingWidth / CGFloat(autoWidthCellCount))
            }
        }
        
        print(self.gridLayout.rowDefinitions)
    }
    
    private func updateGridLayout() {
        for child in self.gridLayout.children {
            var x: CGFloat = 0
            if child.column > 0 {
                for i in 0 ..< child.column {
                    x += self.gridLayout.columnDefinitions[i].width
                }
            }
            
            var y: CGFloat = self.size.height
            if child.row > 0 {
                for i in 0 ..< child.row {
                    y -= self.gridLayout.rowDefinitions[i].height
                }
            }
            
            var width = self.gridLayout.columnDefinitions[child.column].width
            if child.columnSpan > 1 {
                let range = (child.column ..< child.column + (child.columnSpan - 1))
                for i in range {
                    width += self.gridLayout.columnDefinitions[i].width
                }
                
            }
            var height = self.gridLayout.rowDefinitions[child.row].height
            if child.rowSpan > 1 {
                let range = (child.row ..< child.row + (child.rowSpan - 1))
                for i in range {
                    height += self.gridLayout.rowDefinitions[i].height
                }
            }

            switch child.node {
            case let spriteNode as SKSpriteNode:
                let xOffset = (width - spriteNode.size.width) / 2
                let yOffset = (height - spriteNode.size.height) / 2
                print("yOff: \(yOffset) - \(height) - \(spriteNode.size.height)")
                spriteNode.position = CGPoint(x: x + spriteNode.size.width / 2 + xOffset, y: y - spriteNode.size.height / 2 - yOffset)
                break
            case let labelNode as SKLabelNode:
                var xOffset: CGFloat
                switch labelNode.horizontalAlignmentMode {
                case .left: xOffset = 0
                case .center: xOffset = width / 2
                case .right: xOffset = width
                }
                
                var yOffset: CGFloat
                switch labelNode.verticalAlignmentMode {
                case .top: yOffset = 0
                case .bottom: yOffset = -height
                case .center: yOffset = -(height / 2)
                    // TODO: not sure what is proper behaviour for baseline
                case .baseline: yOffset = -(height / 2)
                }

                labelNode.position = CGPoint(x: x + xOffset, y: y + yOffset)
                break
            default: fatalError()
            }
            
            if child.node.parent == nil {
                addChild(child.node)
            }
        }
    }    
}

public class GridLayout {
    public class RowDefinition: CustomStringConvertible {
        var height: CGFloat = 0
        let isAutoSizing: Bool
        
        public init() {
            self.isAutoSizing = true
        }
        
        public init(height: CGFloat) {
            self.height = height
            self.isAutoSizing = false
        }
    }
    
    public class ColumnDefinition: CustomStringConvertible {
        var width: CGFloat = 0
        let isAutoSizing: Bool

        public init() {
            self.isAutoSizing = true
        }
        
        public init(width: CGFloat) {
            self.width = width
            self.isAutoSizing = false
        }
    }
    
    public class Child {
        var column: Int
        var row: Int
        var rowSpan: Int = 1
        var columnSpan: Int = 1
        var node: SKNode

        public convenience init(sprite: SKSpriteNode, row: Int, column: Int, rowSpan: Int = 1, columnSpan: Int = 1) {
            self.init(node: sprite, row: row, column: column, rowSpan: rowSpan, columnSpan: columnSpan)
        }
        
        public convenience init(label: SKLabelNode, row: Int, column: Int, rowSpan: Int = 1, columnSpan: Int = 1) {
            self.init(node: label, row: row, column: column, rowSpan: rowSpan, columnSpan: columnSpan)
        }
        
        private init(node: SKNode, row: Int, column: Int, rowSpan: Int, columnSpan: Int) {
            self.node = node
            self.row = row
            self.column = column
            self.rowSpan = rowSpan
            self.columnSpan = columnSpan
        }
    }

    var rowDefinitions: [RowDefinition]
    
    var columnDefinitions: [ColumnDefinition]
    
    var children: [Child]
    
    public init(rowDefinitions: [RowDefinition], columnDefinitions: [ColumnDefinition], children: [Child]) {
        self.rowDefinitions = rowDefinitions
        self.columnDefinitions = columnDefinitions
        self.children = children
    }
}
