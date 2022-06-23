//
//  ShadowDecorator.swift
//  Marvel
//
//  Created by Andrei Olteanu on 22.06.2022.
//

import UIKit

struct ShadowDecorator: ViewDecorator {

    // MARK: - Private Properties

    private let radius: CGFloat
    private let color: UIColor?
    private let opacity: Float
    private let offset: CGSize?

    // MARK: - Public Properties

    init(radius: CGFloat = 4, color: UIColor? = .black, opacity: Float = 0.15, offset: CGSize = CGSize(width: 0, height: 1)) {
        self.radius = radius
        self.color = color
        self.opacity = opacity
        self.offset = offset
    }

    // MARK: - ViewDecorator

    func decorate(view: UIView) {
        view.layer.masksToBounds = false
        view.layer.shadowColor = color?.cgColor
        if let offset = offset {
            view.layer.shadowOffset = offset
        }
        view.layer.shadowRadius = radius
        view.layer.shadowOpacity = opacity

        view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: radius).cgPath
    }
}
