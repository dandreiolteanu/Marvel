//
//  CharacterComicCollectionViewCell.swift
//  Marvel
//
//  Created by Andrei Olteanu on 23.06.2022.
//

import UIKit
import SnapKit

final class CharacterComicCollectionViewCell: UICollectionViewCell, SelectionAnimating {

    // MARK: - Public Properties

    var viewModel: CharacterComicCellViewModel? {
        didSet {
            titleLabel.text = viewModel?.title
            thumbnailImageView.setImage(with: viewModel?.imageURL)
        }
    }
    
    // MARK: - Private Properties

    private let thumbnailImageView = UIImageView()
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

    override var isSelected: Bool {
        didSet {
            animate(on: isSelected)
        }
    }

    override var isHighlighted: Bool {
        didSet {
            animate(on: isHighlighted)
        }
    }

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
        thumbnailImageView.backgroundColor = .secondaryBackground
        contentView.addSubview(thumbnailImageView)

        titleLabel.font = .tertiaryTextRegular
        titleLabel.textColor = .primaryText
        titleLabel.numberOfLines = 2
        contentView.addSubview(titleLabel)

        thumbnailImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().priority(999)
            $0.width.equalToSuperview()
            $0.height.equalTo(contentView.snp.width).multipliedBy(1.5)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(thumbnailImageView.snp.bottom).offsetBy(.padding)
            $0.leading.trailing.equalToSuperview().priority(999)
            $0.bottom.equalToSuperview().insetBy(.padding).priority(999)
        }
    }
}
