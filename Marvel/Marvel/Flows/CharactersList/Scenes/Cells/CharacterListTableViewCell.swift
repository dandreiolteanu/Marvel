//
//  CharacterListTableViewCell.swift
//  Marvel
//
//  Created by Andrei Olteanu on 22.06.2022.
//

import UIKit
import SnapKit

final class CharacterListTableViewCell: UITableViewCell, SelectionAnimating {

    // MARK: - Public Properties

    var viewModel: CharacterListCellViewModel? {
        didSet {
            titleLabel.text = viewModel?.title
            thumbnailImageView.setImage(with: viewModel?.imageURL)
        }
    }

    // MARK: - Private Properties

    private let containerView = UIStackView()
    private let thumbnailImageView = UIImageView()
    private let titleLabel = UILabel()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        animate(view: containerView, on: selected)
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)

        animate(view: containerView, on: highlighted)
    }

    // MARK: - Private Methods

    private func commonInit() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = backgroundColor

        containerView.backgroundColor = .secondaryBackground
        containerView.decorate(with: AppStyle.normalCornerRadiusDecorator)
        contentView.addSubview(containerView)

        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.clipsToBounds = true
        thumbnailImageView.setImage(with: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/1/b0/5269678709fb7.jpg"))
        containerView.addSubview(thumbnailImageView)

        titleLabel.font = .h1Bold
        titleLabel.textColor = .primaryText
        titleLabel.numberOfLines = 0
        titleLabel.text = ["Deadpool", "Thor"].randomElement()
        containerView.addSubview(titleLabel)

        containerView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().insetBy(.padding).priority(999)
            $0.leading.trailing.equalToSuperview().insetBy(.padding2x).priority(999)
        }

        thumbnailImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.top.greaterThanOrEqualToSuperview().insetBy(.padding2x)
            $0.leading.bottom.trailing.equalToSuperview().insetBy(.padding2x)
        }
    }
}
