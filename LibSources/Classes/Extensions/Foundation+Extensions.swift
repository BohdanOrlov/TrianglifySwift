//
//  Foundation+Extensions.swift
//  TrianglifySwift
//
//  Created by Bohdan Orlov on 29/09/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation


public extension Double {
    static func random() -> Double {
        return Double(arc4random()) / Double(UINT32_MAX)
    }

    static func random(_ min: Double, _ max: Double) -> Double {
        return Double.random() * (max - min) + min
    }
}

public extension CGFloat {
    static func random(_ min: CGFloat, _ max: CGFloat) -> CGFloat {
        return CGFloat(Double.random(Double(min), Double(max)))
    }
}

extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()

        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }

        return result
    }
}

extension Triangle {
    func toPath() -> CGPath {

        let path = CGMutablePath()
        let point1 = vertex1.pointValue()
        let point2 = vertex2.pointValue()
        let point3 = vertex3.pointValue()

        path.move(to: point1)
        path.addLine(to: point2)
        path.addLine(to: point3)
        path.addLine(to: point1)

        path.closeSubpath()

        return path
    }

    func offsetBy(_ offset: CGPoint) -> Triangle {
        return Triangle(vertex1: vertex1.offsetBy(offset), vertex2: vertex2.offsetBy(offset), vertex3: vertex3.offsetBy(offset))
    }

    func center() -> CGPoint {
        let centerX = (vertex1.x + vertex2.x + vertex3.x) / 3
        let centerY = (vertex1.y + vertex2.y + vertex3.y) / 3
        return CGPoint(x: centerX, y: centerY)
    }
}

extension Vertex {
    func pointValue() -> CGPoint {
        return CGPoint(x: x, y: y)
    }

    func offsetBy(_ offset: CGPoint) -> Vertex {
        return Vertex(x: x + Double(offset.x), y: y + Double(offset.y))
    }
}
