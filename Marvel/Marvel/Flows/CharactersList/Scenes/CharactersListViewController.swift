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

    private let viewModel: CharactersListViewModel
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
 
        tableView.rowHeight = UIScreen.main.bounds.width
        tableView.backgroundColor = view.backgroundColor
        tableView.separatorStyle = .none
        tableView.register(cellType: CharacterListTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
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

        viewModel.outputs.dataSourceChanged
            .sink { [weak self] in
                self?.tableView.reloadData()
            }
            .store(in: &subscriptions)

        viewModel.inputs.viewLoaded()
    }
}

// MARK: - UITableViewDataSource

extension CharactersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.outputs.cellViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: CharacterListTableViewCell.self)
        cell.viewModel = viewModel.outputs.cellViewModels[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate

extension CharactersListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
