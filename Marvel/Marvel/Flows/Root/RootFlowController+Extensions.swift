//
//  RootFlowController+Extensions.swift
//  Marvel
//
//  Created by Andrei Olteanu on 21.06.2022.
//

import UIKit

extension RootFlowController {

    // MARK: - Public Properties

    var root: UIViewController? {
        window?.rootViewController
    }

    // MARK: - Public Methods

    func show(flow: FlowController, animated: Bool = true, completion: (() -> Void)? = nil) {
        flow.start(customPresentation: { [weak self] flowMainController in
            self?.setRoot(to: flowMainController, animated: animated) {
                completion?()
            }
        }, animated: animated)
    }
    
    // MARK: - Private Methods

    private func setRoot(to viewController: UIViewController?, animated: Bool = false, completion: (() -> Void)? = nil) {
        guard let viewController = viewController else { return }

        guard root != viewController else { return }

        func changeRoot(to viewController: UIViewController) {
            window?.rootViewController = viewController
        }

        if animated, let snapshotView = window?.snapshotView(afterScreenUpdates: true) {
            viewController.view.addSubview(snapshotView)

            changeRoot(to: viewController)

            UIView.animate(withDuration: 0.33, animations: {
                snapshotView.alpha = 0.0
                snapshotView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            }, completion: { _ in
                snapshotView.removeFromSuperview()
                completion?()
            })
        } else {
            changeRoot(to: viewController)
            completion?()
        }
    }
}
