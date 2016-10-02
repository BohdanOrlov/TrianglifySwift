//
//  Vertex.swift
//  DelaunayTriangulationSwift
//
//  Created by Alex Littlejohn on 2016/01/08.
//  Copyright © 2016 zero. All rights reserved.
//

public struct Vertex {

    public init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }

    public let x: Double
    public let y: Double
}

extension Vertex: Equatable { }

public func ==(lhs: Vertex, rhs: Vertex) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
}

extension Vertex: Hashable {
    public var hashValue: Int {
        return "\(x)\(y)".hashValue
    }
}
