//
//  GradientView.swift
//  Marvel
//
//  Created by Andrei Olteanu on 22.06.2022.
//

import UIKit

final class GradientView: UIView {
    
    // MARK: - Public Properties

    var gradientColors: [UIColor] = [.red, .green] {
        didSet {
            setNeedsLayout()
        }
    }

    var locations: [Double] = [0, 1] {
        didSet {
            setNeedsLayout()
        }
    }

    var startPointX: CGFloat = 0.5 {
        didSet {
            setNeedsLayout()
        }
    }

    var startPointY: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }

    var endPointX: CGFloat = 0.5 {
        didSet {
            setNeedsLayout()
        }
    }

    var endPointY: CGFloat = 1 {
        didSet {
            setNeedsLayout()
        }
    }

    // MARK: - Private Properties

    private var gradientLayer: CAGradientLayer?

    // MARK: - Base Class Overrides

    override class var layerClass: AnyClass {
        CAGradientLayer.self
    }

    override func layoutSubviews() {
        gradientLayer = layer as? CAGradientLayer
        gradientLayer?.colors = gradientColors.map { $0.cgColor }
        gradientLayer?.locations = locations.map { NSNumber(value: $0) }
        gradientLayer?.startPoint = CGPoint(x: startPointX, y: startPointY)
        gradientLayer?.endPoint = CGPoint(x: endPointX, y: endPointY)
    }
}
