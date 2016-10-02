//
//  DemoTrianglesView.swift
//  TrianglifySwift
//
//  Created by Bohdan Orlov on 29/09/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import TrianglifySwift

class DemoTrianglesView: TriangleContainer {
    override func generateTriangles() {
        self.trianglesStyle = self.randomStyle()
        super.generateTriangles()
        for triangleView in self.triangleViews {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(DemoTrianglesView.tapped))
            triangleView.addGestureRecognizer(tapGesture)
        }
    }

    let animationDuration = 0.3
    func tapped(recognizer: UITapGestureRecognizer) {
        let triangleView = recognizer.view as! TriangleView
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseIn, animations: self.animationClosure(view: triangleView), completion:nil)
        let shuffled = self.triangleViews.shuffled()
        let filtered = shuffled.filter() {
            return $0 != triangleView
        }
        self.animateTriangles(triangles: filtered) {
            self.generateTriangles()
        }
    }

    func animateTriangles(triangles: [TriangleView], completion: @escaping (Void) -> Void) {
        var delay = animationDuration

        triangles.enumerated().forEach { idx, triangleView in
            delay += 0.01
            UIView.animate(withDuration: animationDuration / 2.0, delay: delay, options: .curveEaseIn, animations: self.animationClosure(view: triangleView), completion: { _ in
                triangleView.isHidden = true
                if idx == triangles.count - 1 {
                    completion()
                }
            })
        }
    }

    func animationClosure(view: UIView) -> (Void) -> Void {
        return {
            view.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            view.alpha = 0
        }
    }
}

extension DemoTrianglesView {
    func randomStyle() -> TrianglifySwift.Style {
        return Double.random() > 9/10 ? rainbowStyle() : randomGradientStyle()
    }

    func randomGradientStyle() -> TrianglifySwift.Style {
        let colorsX = [UIColor.randomColor(), UIColor.randomColor(), UIColor.randomColor()]
        var colorsY = [UIColor.randomColor(), UIColor.randomColor(), UIColor.randomColor()]
        colorsY = Double.random() > 0.5 ? colorsY : colorsX
        return TrianglifySwift.Style(colorsX: colorsX, colorsY: colorsY)
    }

    func rainbowStyle() -> TrianglifySwift.Style {
        let rainbowColorClosure: (TriangleView) -> UIColor = { triangleView in
            let point = triangleView.relativePositionInSuperview()
            let color = UIColor(hue: (point.x + point.y) / 2.0, saturation: 0.8, brightness: 0.8, alpha: 1)
            return color
        }
        return TrianglifySwift.Style(fillColorClosure:rainbowColorClosure,
                             strokeColorClosure:rainbowColorClosure)
    }
}

extension MutableCollection where Indices.Iterator.Element == Index {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }

        for (unshuffledCount, firstUnshuffled) in zip(stride(from: c, to: 1, by: -1), indices) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            swap(&self[firstUnshuffled], &self[i])
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Iterator.Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}
