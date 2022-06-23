//
//  IconMessageLabelView.swift
//  Marvel
//
//  Created by Andrei Olteanu on 23.06.2022.
//

import UIKit
import SnapKit

final class IconMessageLabelView: UIView {

    // MARK: - Public Properties

    var message: String? {
        didSet {
            messageLabel.text = message
        }
    }

    var icon: UIImage? {
        didSet {
            iconImageView.image = icon
            iconImageView.isHidden = icon == nil
        }
    }

    // MARK: - Private Properties

    private let messageLabel = UILabel()
    private let iconImageView = UIImageView()

    // MARK: - Init

    init(message: String, icon: UIImage?) {
        self.message = message
        self.icon = icon

        super.init(frame: .zero)

        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

        commonInit()
    }
    
    // MARK: - Private Methods

    private func commonInit() {
        backgroundColor = .primaryBackground
        
        iconImageView.image = icon
        iconImageView.isHidden = icon == nil
        iconImageView.contentMode = .scaleAspectFit

        messageLabel.textColor = .primaryText
        messageLabel.font = .secondaryTextMedium
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.text = message

        let contentStackView = UIStackView(arrangedSubviews: [iconImageView, messageLabel])
        contentStackView.axis = .vertical
        contentStackView.distribution = .fill
        contentStackView.spacing = .padding2x
        addSubview(contentStackView)

        contentStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().insetBy(.padding4x)
            $0.top.greaterThanOrEqualToSuperview().insetBy(.padding4x)
            $0.bottom.lessThanOrEqualToSuperview().insetBy(.padding4x)
        }
    }
}
