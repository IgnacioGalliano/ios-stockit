//
//  GradientView.swift
//  StockIt
//
//  Created by Ignacio Galliano on 03/03/2025.
//

import UIKit

class GradientView: UIView {
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if let layer = self.layer as? CAGradientLayer {
            layer.colors = [UIColor(red: 0.36, green: 0.45, blue: 0.52, alpha: 1).cgColor,
                            UIColor(red: 0.15, green: 0.27, blue: 0.36, alpha: 1).cgColor]
            layer.startPoint = CGPoint(x: 0.5, y: 0)
            layer.endPoint = CGPoint(x: 0.5, y: 1)
        }
    }
}

