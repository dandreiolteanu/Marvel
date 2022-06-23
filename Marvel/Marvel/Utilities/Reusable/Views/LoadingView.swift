//
//  LoadingView.swift
//  Marvel
//
//  Created by Andrei Olteanu on 22.06.2022.
//

import UIKit
import SnapKit

final class LoadingView: UIView {

    // MARK: - Private Properties

    private let spinner = UIActivityIndicatorView()

    // MARK: - Init

    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: .padding6x))

        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Private Methods

    private func commonInit() {
        backgroundColor = .clear

        spinner.isHidden = false
        spinner.startAnimating()
        spinner.color = .white
        addSubview(spinner)

        spinner.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
