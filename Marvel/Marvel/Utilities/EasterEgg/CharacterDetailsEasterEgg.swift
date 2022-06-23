//
//  CharacterDetailsEasterEgg.swift
//  Marvel
//
//  Created by Andrei Olteanu on 23.06.2022.
//

import UIKit
import SnapKit

extension CharacterDetailsViewController {

    // MARK: - Public Methods

    func startEasterEgg() {
        let imageView = UIImageView(image: Asset.icnMjolnir.image)
        view.addSubview(imageView)

        imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        let startTransform = CGAffineTransform(translationX: view.bounds.width / 2 + imageView.bounds.height, y: view.bounds.height / 2 + imageView.bounds.height)
        let endTransform = startTransform.inverted()

        imageView.transform = startTransform

        let imageViewAnimator = UIViewPropertyAnimator(duration: 6, curve: .easeIn) { [weak imageView] in
            imageView?.transform = endTransform
        }

        imageViewAnimator.addCompletion { [weak imageView] _ in
            imageView?.layer.removeAllAnimations()
            imageView?.removeFromSuperview()
        }

        imageViewAnimator.startAnimation()
        imageView.rotate()
    }
}

// MARK: - Private Extensions

private extension UIView {

    // MARK: - Public Methods

    func rotate() {
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 0.25
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        layer.add(rotation, forKey: "rotationAnimation")
    }
}
