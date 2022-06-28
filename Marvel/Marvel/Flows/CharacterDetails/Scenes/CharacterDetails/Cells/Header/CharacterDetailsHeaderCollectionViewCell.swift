//
//  CharacterDetailsHeaderCollectionViewCell.swift
//  Marvel
//
//  Created by Andrei Olteanu on 23.06.2022.
//

import UIKit
import SnapKit

final class CharacterDetailsHeaderCollectionViewCell: UICollectionViewCell {

    // MARK: - Public Properties

    var viewModel: CharacterListCellViewModel? {
        didSet {
            titleLabel.text = viewModel?.title
            thumbnailImageView.setImage(with: viewModel?.imageURL)
        }
    }
    
    // MARK: - Private Properties

    private let thumbnailImageView = UIImageView()
    private let gradientView = GradientView()
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

    // MARK: - BaseClass Overrides

    override func prepareForReuse() {
        super.prepareForReuse()

        thumbnailImageView.image = nil
        thumbnailImageView.cancelDownloadImage()
    }

    // MARK: - Private Methods

    private func commonInit() {
        backgroundColor = .clear
        contentView.backgroundColor = backgroundColor

        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.clipsToBounds = true
        contentView.addSubview(thumbnailImageView)

        gradientView.gradientColors = [.secondaryBackground.withAlphaComponent(0.0), .secondaryBackground]
        contentView.addSubview(gradientView)

        titleLabel.font = .h1Bold
        titleLabel.textColor = .primaryText
        titleLabel.numberOfLines = 0
        contentView.addSubview(titleLabel)

        thumbnailImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        gradientView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.5)
        }

        titleLabel.snp.makeConstraints {
            $0.top.greaterThanOrEqualToSuperview().insetBy(.padding2x)
            $0.leading.bottom.trailing.equalToSuperview().insetBy(.padding2x)
        }
    }
}
