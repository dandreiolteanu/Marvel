//
//  LoadingTableViewCell.swift
//  Marvel
//
//  Created by Andrei Olteanu on 22.06.2022.
//

import UIKit
import SnapKit

final class FooterActivityIndicatorView: UIActivityIndicatorView {

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

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
