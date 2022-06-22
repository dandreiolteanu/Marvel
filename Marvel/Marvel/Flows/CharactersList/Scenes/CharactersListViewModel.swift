//
//  CharactersListViewModel.swift
//  Marvel
//
//  Created by Andrei Olteanu on 22.06.2022.
//

import Foundation
import Combine

protocol CharactersListFlowDelegate: AnyObject {
    func shouldShowCharacterDetails(on viewModel: CharactersListViewModel, marvelCharacter: MarvelCharacter)
}

protocol CharactersListViewModelInputs {
    func viewLoaded()
    func loadNextPage()
    func didSelectRow(at indexPath: IndexPath)
}

protocol CharactersListViewModelOutputs {
    var dataSourceSnapshot: CharactersListDiffableSnapshot { get }
    var viewState: AnyPublisher<ViewState, Never> { get }
}

protocol CharactersListViewModel {
    var inputs: CharactersListViewModelInputs { get }
    var outputs: CharactersListViewModelOutputs { get }
}

final class CharactersListViewModelImpl: CharactersListViewModel, CharactersListViewModelInputs, CharactersListViewModelOutputs {

    // MARK: - Section

    enum Section {
        case main
    }

    // MARK: - FlowDelegate

    weak var flowDelegate: CharactersListFlowDelegate?

    // MARK: - Inputs

    var inputs: CharactersListViewModelInputs { self }
    
    // MARK: - Outputs

    var outputs: CharactersListViewModelOutputs { self }

    var dataSourceSnapshot = CharactersListDiffableSnapshot()

    var viewState: AnyPublisher<ViewState, Never> {
        _viewState.eraseToAnyPublisher()
    }

    // MARK: - Private Properties

    private let charactersService: CharactersService

    private var marvelCharacters = [MarvelCharacter]()
    private let _viewState = CurrentValueSubject<ViewState, Never>(.loading)
    private var hasMorePages = true
    private var nextOffset = 0
    private var limit = 10

    // MARK: - Init

    init(charactersService: CharactersService) {
        self.charactersService = charactersService
    }

    // MARK: - Public Methods

    func viewLoaded() {
        loadData(loadingType: .normal)
    }

    func loadNextPage() {
        guard hasMorePages else { return }

        loadData(loadingType: .nextPage)
    }

    func didSelectRow(at indexPath: IndexPath) {
        flowDelegate?.shouldShowCharacterDetails(on: self, marvelCharacter: marvelCharacters[indexPath.row])
    }

    // MARK: - Private Methods

    private func loadData(loadingType: ViewState.LoadingType) {
        _viewState.send(.loading(loadingType))

        charactersService.getCharacters(offset: nextOffset, limit: limit) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let paginated):
                self.hasMorePages = paginated.hasMorePages
                self.nextOffset = paginated.nextOffset
                self.marvelCharacters += paginated.results
                self.dataSourceSnapshot = self.makeSnapshot(from: self.marvelCharacters)

                self._viewState.send(self.marvelCharacters.isEmpty ? .empty : .content)
            case .failure(let error):
                self._viewState.send(.error(error.localizedDescription))
            }
        }
    }

    private func makeSnapshot(from marvelCharacters: [MarvelCharacter]) -> CharactersListDiffableSnapshot {
        var snapshot = CharactersListDiffableSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(marvelCharacters.map(CharacterListCellViewModel.init), toSection: .main)

        return snapshot
    }
}
