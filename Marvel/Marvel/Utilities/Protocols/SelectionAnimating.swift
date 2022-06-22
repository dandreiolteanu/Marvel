//
//  SelectionAnimating.swift
//  Marvel
//
//  Created by Andrei Olteanu on 22.06.2022.
//

import UIKit

protocol SelectionAnimating {
    func animate(view: UIView, on isSelected: Bool)
}

extension SelectionAnimating {
    func animate(view: UIView, on isSelected: Bool) {
        UIView.animate(withDuration: 0.33,
                       delay: 0.0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.9,
                       options: .curveEaseOut,
                       animations: {
            view.transform = isSelected ? .scale : .identity
        }, completion: nil)
    }
}

extension SelectionAnimating where Self: UITableViewCell {
    func animate(on isSelected: Bool) {
        animate(view: self, on: isSelected)
    }
}

extension SelectionAnimating where Self: UICollectionViewCell {
    func animate(on isSelected: Bool) {
        animate(view: self, on: isSelected)
    }
}

extension SelectionAnimating where Self: UIControl {
    func animate(on isSelected: Bool) {
        animate(view: self, on: isSelected)
    }
}

// MARK: - Constants

private extension CGFloat {
    static let scaleFactor: CGFloat = 0.98
}

private extension CGAffineTransform {
    static let scale = CGAffineTransform(scaleX: .scaleFactor, y: .scaleFactor)
}
