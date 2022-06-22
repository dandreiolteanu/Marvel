//
//  UIImageView+Extensions.swift
//  Marvel
//
//  Created by Andrei Olteanu on 22.06.2022.
//

import UIKit
import Kingfisher

extension UIImageView {

    // MARK: - Methods

    func setImage(with url: URL?, placeholder: UIImage? = nil, transition: ImageTransition = .fade(0.33), completion: ((UIImage?) -> Void)? = nil) {
        kf.indicatorType = .activity
        kf.setImage(with: url, placeholder: placeholder, options: [.transition(transition)], completionHandler: { result in
            switch result {
            case .success(let data):
                completion?(data.image)
            case .failure:
                completion?(nil)
            }
        })
    }

    func cancelDownloadImage() {
        kf.cancelDownloadTask()
    }
}
