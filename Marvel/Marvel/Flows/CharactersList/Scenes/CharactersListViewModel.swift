//
//  CharactersListViewModel.swift
//  Marvel
//
//  Created by Andrei Olteanu on 22.06.2022.
//

import Foundation
import Combine
import Moya

protocol CharactersListFlowDelegate: AnyObject {
    func shouldShowCharacterDetails(on viewModel: CharactersListViewModel, marvelCharacter: MarvelCharacter)
}

protocol CharactersListViewModelInputs {
    func viewLoaded()
    func loadNextPage()
    func didSelectRow(at indexPath: IndexPath)
    func updateSearchQuery(with query: String?)
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

    private let _viewState = CurrentValueSubject<ViewState, Never>(.loading)
    private var searchQuery: String?
    private var hasMorePages = true
    private var nextOffset = 0
    private let limit = 10

    private var marvelCharacters = [MarvelCharacter]() {
        didSet {
            dataSourceSnapshot = makeSnapshot(from: marvelCharacters)
        }
    }

    private var loadTask: Moya.Cancellable? {
        willSet {
            loadTask?.cancel()
        }
    }

    // MARK: - Init

    init(charactersService: CharactersService) {
        self.charactersService = charactersService
    }

    // MARK: - Public Methods

    func viewLoaded() {
        loadData(loadingType: .normal, query: nil)
    }

    func loadNextPage() {
        guard hasMorePages else { return }

        loadData(loadingType: .nextPage, query: searchQuery)
    }

    func didSelectRow(at indexPath: IndexPath) {
        flowDelegate?.shouldShowCharacterDetails(on: self, marvelCharacter: marvelCharacters[indexPath.row])
    }

    func updateSearchQuery(with query: String?) {
        guard query?.nilIfEmpty != searchQuery?.nilIfEmpty else { return }
    
        searchQuery = query
        hasMorePages = true
        nextOffset = 0

        loadData(loadingType: .normal, query: searchQuery)
    }

    // MARK: - Private Methods

    private func loadData(loadingType: ViewState.LoadingType, query: String?) {
        _viewState.send(.loading(loadingType))

        loadTask = charactersService.getCharacters(offset: nextOffset, limit: limit, query: query) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let paginated):
                self.hasMorePages = paginated.hasMorePages
                self.nextOffset = paginated.nextOffset

                if paginated.offset == 0 {
                    self.marvelCharacters = paginated.results
                } else {
                    self.marvelCharacters += paginated.results
                }
                
                self._viewState.send(self.marvelCharacters.isEmpty ? .empty : .content)
            case .failure(let error):
                guard !error.isCancel else { return }

                self.marvelCharacters.removeAll()

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
