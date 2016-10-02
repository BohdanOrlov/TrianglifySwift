//
//  Style.swift
//  Pods
//
//  Created by Bohdan Orlov on 01/10/2016.
//
//

import Foundation
import UIKit

public struct Style {
    public let colorsX: [UIColor]
    public let colorsY: [UIColor]
    public let fillColorClosure: ((TriangleView) -> UIColor)
    public let strokeColorClosure: ((TriangleView) -> UIColor)
    public let strokeLineWidth: CGFloat

    public init(colorsX: [UIColor] = [UIColor.randomColor(), UIColor.randomColor(), UIColor.randomColor()],
                colorsY: [UIColor] = [UIColor.randomColor(), UIColor.randomColor(), UIColor.randomColor()],
                fillColorClosure: ((TriangleView) -> UIColor)? = nil,
                strokeColorClosure: ((TriangleView) -> UIColor)? = nil,
                strokeLineWidth: CGFloat = 0.51) {
        self.colorsX = colorsX
        self.colorsY = colorsY
        self.fillColorClosure = fillColorClosure ?? Style.gradientColorClosure(colorsX: colorsX, colorsY: colorsY)
        self.strokeColorClosure = strokeColorClosure ?? Style.gradientColorClosure(colorsX: colorsX, colorsY: colorsY)
        self.strokeLineWidth = strokeLineWidth
    }

    private static func gradientColorClosure(colorsX: [UIColor], colorsY: [UIColor]) -> (TriangleView) -> UIColor {
        return { triangleView in
            let point = triangleView.relativePositionInSuperview()
            let color = UIColor.interpolateFrom(fromColor: UIColor.interpolate(colors: colorsX, progress: point.x), to: UIColor.interpolate(colors: colorsY, progress: point.y), withProgress: 0.5)
            return color
        }
    }
}

public extension UIView {
    func relativePositionInSuperview() -> CGPoint {
        guard let superview = self.superview else { assert(false); return CGPoint.zero}
        let superviewWidth = superview.bounds.size.width
        let superviewHeight = superview.bounds.size.height
        let centerInBounds = CGPoint(x: min(max(0, self.center.x), superviewWidth), y: min(max(0, self.center.y), superviewHeight))
        let point = CGPoint(x: centerInBounds.x / superviewWidth, y: centerInBounds.y / superviewHeight)
        return point
    }
}
