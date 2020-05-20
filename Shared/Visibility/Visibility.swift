//
//  Visibility.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 20/05/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import CoreGraphics
import simd

// Code is based on the algorithm described here:
// http://www.adammil.net/blog/v125_Roguelike_Vision_Algorithms.html

/// Visibility algorithms should conform to this protocol, in order for algorithms to be changed as needed.
public protocol Visibility {
    /// Update the current visibility.
    /// - Parameters:
    ///   - origin: The coordinate for which visibiliy needs to be calculated.
    ///   - rangeLimit: The maximum visibility range from the origin.
    func compute(origin: vector_int2, rangeLimit: Int32)
}

/// A raycasting algorithm that can be used on a 2D grid.
final public class RaycastVisibility: Visibility {
    private let mapSize: CGSize
    private let blocksLight: (vector_int2) -> (Bool)
    private let setVisible: (vector_int2) -> ()
    private let getDistance: (vector_int2, vector_int2) -> Int
        
    /// The constructor.
    /// - Parameters:
    ///   - mapSize: Size of the map.
    ///   - blocksLight: A block method that determines if a coordinate blocks a light (e.g. a wall would return true, an open area would return false).
    ///   - setVisible: A block method that is used to make a coordinate visibile.
    ///   - getDistance: Calculate the distance between 2 coordinates, which is used to determine if a coordinate is in the visibility range limit.
    init(mapSize: CGSize,
         blocksLight: @escaping (vector_int2) -> (Bool),
         setVisible: @escaping (vector_int2) -> (),
         getDistance: @escaping (vector_int2, vector_int2) -> Int)  {
        self.mapSize = mapSize
        self.blocksLight = blocksLight
        self.setVisible = setVisible
        self.getDistance = getDistance
    }
        
    /// Compute visibilty using the raycaster.
    /// - Parameters:
    ///   - origin: Origin of raycasting beams.
    ///   - rangeLimit: Maximum range of raycasting beams.
    public func compute(origin: vector_int2, rangeLimit: Int32) {
        setVisible(origin)
        
        if rangeLimit != 0 {
            let area = CGRect(x: 0, y: 0, width: mapSize.width, height: mapSize.height)
            if rangeLimit >= 0 {
                area.intersects(CGRect(x: (Int)(origin.x - rangeLimit), y: (Int)(origin.y - rangeLimit), width: Int(rangeLimit * 2 + 1), height: Int(rangeLimit * 2 + 1)))
            }

            let xRange = Int32(area.minX) ..< Int32(area.maxX)
            for x in xRange {
                traceLine(origin: origin, x2: x, y2: Int32(area.maxY), rangeLimit: rangeLimit)
                traceLine(origin: origin, x2: x, y2: Int32(area.minY) - 1, rangeLimit: rangeLimit)
            }
            
            let yRange = Int32(area.minY - 1) ..< Int32(area.maxY + 1)
            for y in yRange.reversed() {
                traceLine(origin: origin, x2: Int32(area.minX), y2: y, rangeLimit: rangeLimit)
                traceLine(origin: origin, x2: Int32(area.maxX) - 1, y2: y, rangeLimit: rangeLimit)
            }
        }
    }
    
    // MARK: - Private
    
    private func traceLine(origin: vector_int2, x2: Int32, y2: Int32, rangeLimit: Int32) {
        let xDiff = x2 - origin.x
        let yDiff = y2 - origin.y
        var xLen = abs(xDiff)
        var yLen = abs(yDiff)
        var xInc = xDiff.signum()
        var yInc = yDiff.signum() << 16
        var index = (origin.y << 16) + origin.x
        if (xLen < yLen) {
            (xLen, yLen) = (yLen, xLen)
            (xInc, yInc) = (yInc, xInc)
        }
        let errorInc = yLen * 2
        var error = -(xLen)
        let errorReset = xLen * 2
        xLen -= 1
        while (xLen >= 0) {
            index += xInc
            error += errorInc
            if (error > 0) {
                error -= errorReset
                index += yInc
            }
            let x = index & 0xffff
            let y = index >> 16
            let destination = vector_int2(x, y)
            if rangeLimit >= 0 && getDistance(origin, destination) > rangeLimit {
                break
            }
            setVisible(destination)
            if blocksLight(destination) { break }
        }
    }
}
