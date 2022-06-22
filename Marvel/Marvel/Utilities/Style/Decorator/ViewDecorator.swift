//
//  ViewDecorator.swift
//  Marvel
//
//  Created by Andrei Olteanu on 22.06.2022.
//

import UIKit

protocol ViewDecorator {
    func decorate(view: UIView)
}

extension Array where Element: UIView {
    func decorate(with decorator: ViewDecorator) {
        forEach { decorator.decorate(view: $0) }
    }

    func decorate(with decorators: [ViewDecorator]) {
        forEach { view in
            decorators.forEach {
                $0.decorate(view: view)
            }
        }
    }
}

extension UIView {
    func decorate(with decorator: ViewDecorator) {
        decorator.decorate(view: self)
    }

    func decorate(with decorators: [ViewDecorator]) {
        decorators.forEach {
            $0.decorate(view: self)
        }
    }
}
