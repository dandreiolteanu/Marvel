//
//  BlurPresentationController.swift
//  Marvel
//
//  Created by Andrei Olteanu on 23.06.2022.
//

import UIKit
import SnapKit

final class BlurPresentationController: UIPresentationController {
    
    // MARK: - Private Properties

    private let blurView = UIVisualEffectView(effect: nil)

    // MARK: - BaseClass Overrides
    
    override var presentationStyle: UIModalPresentationStyle {
        .overCurrentContext
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        guard let containerView = containerView else { return }
        containerView.addSubview(blurView)
        blurView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        guard let coordinator = presentingViewController.transitionCoordinator else { return }
        coordinator.animate { [weak self] _ in
            self?.blurView.effect = UIBlurEffect(style: .prominent)
        }
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        
        guard let coordinator = presentedViewController.transitionCoordinator else { return }
        coordinator.animate { [weak self] _ in
            self?.blurView.effect = nil
        }
    }
}
