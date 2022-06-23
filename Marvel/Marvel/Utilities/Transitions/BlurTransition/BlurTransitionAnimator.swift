//
//  BlurTransitionAnimator.swift
//  Marvel
//
//  Created by Andrei Olteanu on 23.06.2022.
//

import UIKit

final class BlurTransitionAnimator: NSObject, UIViewControllerTransitioningDelegate {
    
    // MARK: - UIViewControllerTransitioningDelegate

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        BlurPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        DefaultPresentAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        DefaultDismissAnimator()
    }
}

private class DefaultPresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    // MARK: - UIViewControllerAnimatedTransitioning

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        .animationDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to) else { return }

        transitionContext.containerView.addSubview(toViewController.view)

        toViewController.view.alpha = 0
        toViewController.view.transform = CGAffineTransform(translationX: 0, y: toViewController.view.bounds.height)

        let animator = UIViewPropertyAnimator(duration: transitionDuration(using: transitionContext), dampingRatio: .dampingRatio) {
            toViewController.view.alpha = 1
            toViewController.view.transform = .identity
        }

        animator.addCompletion { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }

        animator.startAnimation()
    }
}

private class DefaultDismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    // MARK: - UIViewControllerAnimatedTransitioning

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        .animationDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from) else { return }

        let animator = UIViewPropertyAnimator(duration: transitionDuration(using: transitionContext), dampingRatio: .dampingRatio) {
            fromViewController.view.alpha = 0
            fromViewController.view.transform = CGAffineTransform(translationX: 0, y: fromViewController.view.bounds.height)
        }

        animator.addCompletion { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }

        animator.startAnimation()
    }
}

// MARK: - Constants

private extension CGFloat {
    static let dampingRatio: CGFloat = 0.95
}

private extension TimeInterval {
    static let animationDuration: TimeInterval = 0.4
}
