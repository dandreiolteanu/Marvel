//
//  CharacterDetailsViewController.swift
//  Marvel
//
//  Created by Andrei Olteanu on 23.06.2022.
//

import Combine
import UIKit
import SnapKit

final class CharacterDetailsViewController: BaseViewController {

    // MARK: - Private Properties

    private lazy var collectionView: UICollectionView = {
        UICollectionView(frame: .zero, collectionViewLayout: CharacterDetailsCompositionalLayout { [weak self] in
            self?.viewModel.outputs.dataSourceSnapshot.sectionIdentifiers[$0].layoutType ?? .gridVertical
        })
    }()
    private let topGradientView = GradientView()
    private let closeButton = UIButton()

    private let viewModel: CharacterDetailsViewModel
    private lazy var dataSource: CharacterDetailsDiffableDataSource = makeDataSource()
    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Init

    init(viewModel: CharacterDetailsViewModel) {
        self.viewModel = viewModel

        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - BaseClass Overrides

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard viewModel.outputs.hasEasterEgg else { return }

        startEasterEgg()
    }

    override func setupView() {
        super.setupView()

        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = .primaryBackground.withAlphaComponent(0.5)
 
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        collectionView.register(cellType: CharacterDetailsHeaderCollectionViewCell.self)
        collectionView.register(cellType: TitleCollectionViewCell.self)
        collectionView.register(cellType: CharacterComicCollectionViewCell.self)
        collectionView.register(supplementaryViewType: TitleCollectionReusableView.self, ofKind: TitleCollectionReusableView.reuseIdentifier)
        collectionView.backgroundColor = view.backgroundColor
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.contentInset.bottom = .padding4x
        view.addSubview(collectionView)

        topGradientView.gradientColors = [.primaryBackground, .primaryBackground.withAlphaComponent(0.0)]
        view.addSubview(topGradientView)

        closeButton.setImage(Asset.icnClose.image, for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonTouched), for: .touchUpInside)
        view.addSubview(closeButton)
    }

    override func setupConstraints() {
        super.setupConstraints()

        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        topGradientView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(closeButton.snp.bottom).offsetBy(.padding2x)
        }

        closeButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).insetBy(.padding)
            $0.trailing.equalToSuperview().insetBy(.padding2x)
        }
    }

    override func setupBindings() {
        super.setupBindings()

        viewModel.outputs.viewState
            .removeDuplicates()
            .sink { [weak self] in
                self?.handleViewState($0)
            }
            .store(in: &subscriptions)

        viewModel.inputs.viewLoaded()
    }

    // MARK: - Private Methods

    private func handleViewState(_ state: ViewState) {
        collectionView.setState(state)

        switch state {
        case .content, .empty, .error:
            dataSource.apply(viewModel.outputs.dataSourceSnapshot, animatingDifferences: true)
        default:
            break
        }
    }

    @objc private func closeButtonTouched() {
        viewModel.inputs.closeTouched()
    }
}

// MARK: - CharacterDetailsDiffableDataSource

extension CharacterDetailsViewController {
    private func makeDataSource() -> CharacterDetailsDiffableDataSource {
        let dataSource = CharacterDetailsDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, item in
            switch item {
            case .headerItem(let cellViewModel):
                let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: CharacterDetailsHeaderCollectionViewCell.self)
                cell.viewModel = cellViewModel

                return cell
            case .descriptionItem(let cellViewModel):
                let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: TitleCollectionViewCell.self)
                cell.title = cellViewModel

                return cell
            case .comicsItem(let cellViewModel):
                let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: CharacterComicCollectionViewCell.self)
                cell.viewModel = cellViewModel

                return cell
            }
        }

        dataSource.supplementaryViewProvider = supplementaryViewProvider(collectionView:kind:indexPath:)

        return dataSource
    }

    private func supplementaryViewProvider(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? {
        guard kind == TitleCollectionReusableView.reuseIdentifier else { return nil }

        let view = collectionView.dequeueReusableSupplementaryView(ofKind: TitleCollectionReusableView.reuseIdentifier, for: indexPath, viewType: TitleCollectionReusableView.self)
        view.title = viewModel.outputs.dataSourceSnapshot.sectionIdentifiers[indexPath.section].title

        return view
    }
}

// MARK: - UICollectionViewDelegate

extension CharacterDetailsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        viewModel.inputs.didSelectItem(at: indexPath)
    }
}
