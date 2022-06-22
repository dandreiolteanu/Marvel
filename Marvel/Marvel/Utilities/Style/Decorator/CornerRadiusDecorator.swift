//
//  CornerRadiusDecorator.swift
//  Marvel
//
//  Created by Andrei Olteanu on 22.06.2022.
//

import UIKit

struct CornerRadiusDecorator: ViewDecorator {
    let radius: CGFloat?

    init(radius: CGFloat? = nil) {
        self.radius = radius
    }

    func decorate(view: UIView) {
        view.layer.cornerRadius = radius ?? min(view.frame.width, view.frame.height) / 2
        view.layer.masksToBounds = true
    }
}
