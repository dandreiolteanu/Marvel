//
//  LoadingView.swift
//  Marvel
//
//  Created by Andrei Olteanu on 22.06.2022.
//

import UIKit

final class LoadingView: UIActivityIndicatorView {

    // MARK: - Init

    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: .padding6x))

        commonInit()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)

        commonInit()
    }
    
    // MARK: - Private Methods

    private func commonInit() {
        isHidden = false
        startAnimating()
        color = .white
    }
}
