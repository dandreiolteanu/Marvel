//
//  SplashScreenBannerAnimating.swift
//  Marvel
//
//  Created by Andrei Olteanu on 22.06.2022.
//

import UIKit
import SnapKit

protocol ReplicatedViewAnimating {
    var replicatorsNumber: Int { get }

    func replicatedView(at replicatorNumber: Int) -> UIView
}

extension ReplicatedViewAnimating where Self: SplashScreenViewController {

    func startReplicatingAnimation() {
        var replicatedViews = [UIView]()

        for i in 0..<replicatorsNumber {
            let replicatedView = replicatedView(at: i)
            replicatedView.layer.zPosition = 0 - CGFloat(i)
            replicatedViews.append(replicatedView)
            
            view.addSubview(replicatedView)
            replicatedView.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
        }

        func repeatAnimation() {
            replicatedViews.enumerated().forEach {
                guard $0.offset > 0 else { return }

                $0.element.alpha = 0
                $0.element.transform = CGAffineTransform(translationX: -12 * CGFloat($0.offset), y: -12 * CGFloat($0.offset))
            }

            UIView.animate(withDuration: 0.33) {
                replicatedViews.forEach {
                    $0.alpha = 1
                }
            }

            let animationDuration: CGFloat = 0.3
            replicatedViews.enumerated().forEach { offset, element in
                UIView.animate(withDuration: animationDuration,
                               delay: animationDuration * sqrt(Double(offset)),
                               options: .curveEaseIn,
                               animations: {
                    element.transform = .identity
                },
                               completion: { _ in
                    if offset == replicatedViews.count - 1 {
                        repeatAnimation()
                    }
                })
            }
        }

        repeatAnimation()
    }
}
