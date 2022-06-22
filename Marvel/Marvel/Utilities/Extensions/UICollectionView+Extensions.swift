//
//  UICollectionView+Extensions.swift
//  Marvel
//
//  Created by Andrei Olteanu on 22.06.2022.
//

import UIKit

extension UICollectionView {

    // MARK: - Public Methods

    func setState(_ viewState: ViewState) {
        backgroundView = viewState.backgroundView
    }
}
