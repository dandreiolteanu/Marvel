//
//  BorderDecorator.swift
//  Marvel
//
//  Created by Andrei Olteanu on 22.06.2022.
//

import UIKit

struct BorderDecorator: ViewDecorator {
    private let borderWidth: CGFloat
    private let borderColor: UIColor?

    init(borderWidth: CGFloat = 2, borderColor: UIColor? = .white) {
        self.borderWidth = borderWidth
        self.borderColor = borderColor
    }

    func decorate(view: UIView) {
        view.layer.borderWidth = borderWidth
        view.layer.borderColor = borderColor?.cgColor
    }
}
