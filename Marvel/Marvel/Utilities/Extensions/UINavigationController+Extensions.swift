//
//  UINavigationController+Extensions.swift
//  Marvel
//
//  Created by Andrei Olteanu on 21.06.2022.
//

import UIKit

extension UINavigationController {

    // MARK: - Public Methods

    func pushViewController(viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        pushViewController(viewController, animated: animated)

        if animated, let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion?()
            }
        } else {
            completion?()
        }
    }

    @discardableResult
    func popViewController(animated: Bool, completion: (() -> Void)? = nil) -> UIViewController? {
        let viewController = popViewController(animated: animated)

        if animated, let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion?()
            }
        } else {
            completion?()
        }

        return viewController
    }

    @discardableResult
    func popToRootViewController(animated: Bool, completion: (() -> Void)? = nil) -> [UIViewController]? {
        let viewControllers = popToRootViewController(animated: animated)

        if animated, let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion?()
            }
        } else {
            completion?()
        }

        return viewControllers
    }
}
