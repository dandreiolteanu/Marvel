//
//  CharactersListViewController.swift
//  Marvel
//
//  Created by Andrei Olteanu on 22.06.2022.
//

import Combine
import UIKit
import SnapKit

final class CharactersListViewController: BaseViewController {

    // MARK: - Private Properties

    private let tableView = UITableView()
    private var footerActivityIndicatorView: FooterActivityIndicatorView?

    private let viewModel: CharactersListViewModel
    private lazy var dataSource: CharactersListDiffableDataSource = {
        let dataSource = makeDataSource()
        dataSource.defaultRowAnimation = .top
        return dataSource
    }()
    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Init

    init(viewModel: CharactersListViewModel) {
        self.viewModel = viewModel

        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - BaseClass Overrides

    override func setupView() {
        super.setupView()

        navigationItem.titleView = UIImageView(image: Asset.imgNavBar.image)
        view.backgroundColor = .primaryBackground
 
        tableView.register(cellType: CharacterListTableViewCell.self)
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.rowHeight = UIScreen.main.bounds.width
        tableView.backgroundColor = view.backgroundColor
        tableView.separatorStyle = .none
        view.addSubview(tableView)
    }

    override func setupConstraints() {
        super.setupConstraints()

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
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
        footerActivityIndicatorView?.removeFromSuperview()
        tableView.tableFooterView = nil
        
        switch state {
        case .content:
            dataSource.apply(viewModel.outputs.dataSourceSnapshot, animatingDifferences: true)
            tableView.tableFooterView = nil
        case .loading(let loadingType):
            switch loadingType {
            case .normal:
                // TODO: - handle normal loading type
                break
            case .nextPage:
                footerActivityIndicatorView = FooterActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: .padding6x))
                tableView.tableFooterView = footerActivityIndicatorView
            }
        case .empty:
            // TODO: - Handle empty state
            break
        case .error:
            // TODO: - Handle error
            break
        }
    }
}

// MARK: - CharactersListTableViewDiffableDataSource

extension CharactersListViewController {
    private func makeDataSource() -> CharactersListDiffableDataSource {
        CharactersListDiffableDataSource(tableView: tableView) { tableView, indexPath, cellViewModel in
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: CharacterListTableViewCell.self)
            cell.viewModel = cellViewModel
            return cell
        }
    }
}

// MARK: - UITableViewDelegate

extension CharactersListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == viewModel.outputs.dataSourceSnapshot.itemIdentifiers.count - 1 else { return }

        viewModel.inputs.loadNextPage()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
