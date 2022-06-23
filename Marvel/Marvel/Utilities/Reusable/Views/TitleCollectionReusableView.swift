//
//  TitleCollectionReusableView.swift
//  Marvel
//
//  Created by Andrei Olteanu on 23.06.2022.
//

import UIKit
import SnapKit

final class TitleCollectionReusableView: UICollectionReusableView {

    // MARK: - Public Properties

    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    // MARK: - Private Properties

    private let titleLabel = UILabel()
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

        commonInit()
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        backgroundColor = .clear

        titleLabel.font = .bodyBold
        titleLabel.textColor = .secondaryText
        addSubview(titleLabel)

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().insetBy(.padding2x).priority(999)
            $0.bottom.equalToSuperview().insetBy(.padding2x).priority(999)
        }
    }
}
