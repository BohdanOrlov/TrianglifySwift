//
//  VerticesGenerator.swift
//  Pods
//
//  Created by Bohdan Orlov on 01/10/2016.
//
//

import Foundation
import GameplayKit

open class VerticesGenerator {
    public struct Configuration {
        let size: CGSize
        let cellSize: CGFloat
        let variance: CGFloat
        let seed: UInt64

        init(size: CGSize = CGSize(width: 320, height: 320), cellSize: CGFloat = 80, variance: CGFloat = 0.75, seed: UInt64 = numericCast(arc4random())) {
            self.size = size
            self.cellSize = cellSize
            self.variance = variance
            self.seed = seed
        }
    }
    open static func generate(configuration: VerticesGenerator.Configuration = VerticesGenerator.Configuration()) -> [Vertex] {

        // How many cells we're going to have on each axis (pad by 2 cells on each edge)
        let cellsX = (configuration.size.width + 4 * configuration.cellSize) / configuration.cellSize
        let cellsY = (configuration.size.height + 4 * configuration.cellSize) / configuration.cellSize

        // figure out the bleed widths to center the grid
        let bleedX = ((cellsX * configuration.cellSize) - configuration.size.width)/2
        let bleedY = ((cellsY * configuration.cellSize) - configuration.size.height)/2

        let _variance = configuration.cellSize * configuration.variance / 4

        var points = [Vertex]()
        let minX = -bleedX
        let maxX = configuration.size.width + bleedX
        let minY = -bleedY
        let maxY = configuration.size.height + bleedY

        let generator = GKLinearCongruentialRandomSource(seed: configuration.seed)

        for i in stride(from: minX, to: maxX, by: configuration.cellSize) {
            for j in stride(from: minY, to: maxY, by: configuration.cellSize) {

                let x = i + configuration.cellSize/2 + CGFloat(generator.nextUniform()) + CGFloat.random(-_variance, _variance)
                let y = j + configuration.cellSize/2 + CGFloat(generator.nextUniform()) + CGFloat.random(-_variance, _variance)

                points.append(Vertex(x: Double(x), y: Double(y)))
            }
        }

        return points
    }
}
