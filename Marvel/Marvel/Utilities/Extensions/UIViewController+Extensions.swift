//
//  UIViewController+Extensions.swift
//  Marvel
//
//  Created by Andrei Olteanu on 24.06.2022.
//

import UIKit
import SnapKit

extension UIViewController {
 
    // MARK: - Public Methods

    func addChildViewController(_ viewController: UIViewController, to container: UIView, insets: UIEdgeInsets = .zero) {
        addChild(viewController)
        container.addSubview(viewController.view)

        viewController.didMove(toParent: self)
        viewController.view.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(insets)
        }
    }

    func removeFromParentViewController() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
