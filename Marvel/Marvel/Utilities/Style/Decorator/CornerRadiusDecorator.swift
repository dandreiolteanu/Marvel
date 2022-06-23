//
//  CornerRadiusDecorator.swift
//  Marvel
//
//  Created by Andrei Olteanu on 22.06.2022.
//

import UIKit

struct CornerRadiusDecorator: ViewDecorator {

    // MARK: - Private Properties

    private let radius: CGFloat?

    // MARK: - Init

    init(radius: CGFloat? = nil) {
        self.radius = radius
    }

    // MARK: - ViewDecorator

    func decorate(view: UIView) {
        view.layer.cornerRadius = radius ?? min(view.frame.width, view.frame.height) / 2
        view.layer.masksToBounds = true
    }
}
