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
    private let searchController = UISearchController(searchResultsController: nil)

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

        definesPresentationContext = true
        navigationItem.titleView = UIImageView(image: Asset.imgNavBar.image)
        navigationItem.searchController = searchController
        view.backgroundColor = .primaryBackground

        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = .marvelRed
        searchController.searchBar.placeholder = L10n.Characters.searchPlaceholder
        searchController.searchBar.returnKeyType = .done
        searchController.searchBar.barStyle = .black
 
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.register(cellType: CharacterListTableViewCell.self)
        tableView.rowHeight = UIScreen.main.bounds.width
        tableView.backgroundColor = view.backgroundColor
        tableView.keyboardDismissMode = .interactive
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
        tableView.setState(state)

        switch state {
        case .content, .empty, .error:
            dataSource.apply(viewModel.outputs.dataSourceSnapshot, animatingDifferences: true)
        default:
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

        viewModel.inputs.didSelectRow(at: indexPath)
    }
}

// MARK: - UISearchBarDelegate

extension CharactersListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.inputs.updateSearchQuery(with: searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.inputs.updateSearchQuery(with: nil)
    }
}
