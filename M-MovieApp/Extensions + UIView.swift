//
//  Extensions + UIView.swift
//  M-MovieApp
//
//  Created by Bahadır Enes Atay on 6.05.2022.
//

import Foundation
import UIKit

extension UIView {
    func createGradientLayer(colors: [CGColor], viewFrame: CGRect, startPoint: CGPoint, endPoint: CGPoint) {
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.frame = viewFrame
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.colors = colors
        gradientLayer.drawsAsynchronously = true
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
