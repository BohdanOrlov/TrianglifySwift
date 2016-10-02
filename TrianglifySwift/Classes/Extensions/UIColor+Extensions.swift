//
//  UIColor+Extensions.swift
//  TrianglifySwift
//
//  Created by Bohdan Orlov on 29/09/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
    var components: (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {

        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        if self.cgColor.numberOfComponents == 2 {
            let components = self.cgColor.components!
            red = components[0]
            green = components[0]
            blue = components[0]
            alpha = components[1]
        } else {
            self.getRed(&red, green:&green, blue: &blue, alpha: &alpha)
        }
        return (r: red, g: green, b: blue, a: alpha)
    }

    public static func interpolateFrom(fromColor: UIColor, to toColor: UIColor, withProgress progress: CGFloat) -> UIColor {
        if fromColor == toColor {
            return toColor
        }
        let fromComponents = fromColor.components
        let toComponents = toColor.components

        let r = (1 - progress) * fromComponents.r + progress * toComponents.r
        let g = (1 - progress) * fromComponents.g + progress * toComponents.g
        let b = (1 - progress) * fromComponents.b + progress * toComponents.b
        let a = (1 - progress) * fromComponents.a + progress * toComponents.a

        return UIColor(red: r, green: g, blue: b, alpha: a)
    }

    public static func interpolate(colors: [UIColor], progress: CGFloat) -> UIColor {
        let idx1 = Int(floor(CGFloat((colors.count - 1)) * progress))
        let idx2 = Int(ceil(CGFloat((colors.count - 1)) * progress))
        let step = 1 / CGFloat(colors.count - 1)
        let offset = CGFloat(idx1) * step
        let newProgress = (progress - offset) / step
        let color1 = colors[idx1]
        let color2 = colors[idx2]
        let interpolatedColor = UIColor.interpolateFrom(fromColor: color1, to: color2, withProgress: newProgress)
        return interpolatedColor
    }

    public static func randomColor() -> UIColor {
        let hue = CGFloat( Double.random() )  // 0.0 to 1.0
        let saturation: CGFloat = 0.5  // 0.5 to 1.0, away from white
        let brightness: CGFloat = 1.0  // 0.5 to 1.0, away from black
        let color = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
        return color
    }
}
