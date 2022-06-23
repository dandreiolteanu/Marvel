//
//  CharacterDetailsViewModel.swift
//  Marvel
//
//  Created by Andrei Olteanu on 23.06.2022.
//

import Foundation
import Combine

protocol CharacterDetailsFlowDelegate: AnyObject {
    func didPressClose(on viewModel: CharacterDetailsViewModel)
}

protocol CharacterDetailsViewModelInputs {
    func viewLoaded()
    func closeTouched()
}

protocol CharacterDetailsViewModelOutputs {
    var dataSourceSnapshot: CharacterDetailsDiffableSnapshot { get }
    var viewState: AnyPublisher<ViewState, Never> { get }
    var hasEasterEgg: Bool { get }
}

protocol CharacterDetailsViewModel {
    var inputs: CharacterDetailsViewModelInputs { get }
    var outputs: CharacterDetailsViewModelOutputs { get }
}

final class CharacterDetailsViewModelImpl: CharacterDetailsViewModel, CharacterDetailsViewModelInputs, CharacterDetailsViewModelOutputs {

    // MARK: - FlowDelegate

    weak var flowDelegate: CharacterDetailsFlowDelegate?

    // MARK: - Inputs

    var inputs: CharacterDetailsViewModelInputs { self }
    
    // MARK: - Outputs

    var outputs: CharacterDetailsViewModelOutputs { self }

    var dataSourceSnapshot = CharacterDetailsDiffableSnapshot()
    let hasEasterEgg: Bool

    var viewState: AnyPublisher<ViewState, Never> {
        _viewState.eraseToAnyPublisher()
    }

    // MARK: - Private Properties

    private let characterComicsService: CharacterComicsService

    private let _viewState = CurrentValueSubject<ViewState, Never>(.content)
    private let marvelCharacter: MarvelCharacter

    private var characterComics = [MarvelComic]() {
        didSet {
            dataSourceSnapshot = makeSnapshot(with: marvelCharacter, and: characterComics)
        }
    }

    // MARK: - Init

    init(marvelCharacter: MarvelCharacter, characterComicsService: CharacterComicsService, easterEggService: EasterEggService) {
        self.marvelCharacter = marvelCharacter
        self.characterComicsService = characterComicsService
        self.hasEasterEgg = easterEggService.hasEasterEgg
        self.dataSourceSnapshot = makeSnapshot(with: marvelCharacter, and: characterComics)
    }

    // MARK: - Public Methods

    func viewLoaded() {
        loadData(loadingType: .normal)
    }

    func closeTouched() {
        flowDelegate?.didPressClose(on: self)
    }

    // MARK: - Private Methods

    private func loadData(loadingType: ViewState.LoadingType) {
        _viewState.send(.loading(loadingType))

        characterComicsService.getComics(marvelCharacterId: marvelCharacter.id) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let paginated):
                self.characterComics = paginated.results
                
                self._viewState.send(.content)
            case .failure(let error):
                self.characterComics.removeAll()

                self._viewState.send(.error(error.localizedDescription))
            }
        }
    }

    private func makeSnapshot(with marvelCharacter: MarvelCharacter, and characterComics: [MarvelComic]) -> CharacterDetailsDiffableSnapshot {
        var snapshot = CharacterDetailsDiffableSnapshot()

        snapshot.appendSections([.header])
        snapshot.appendItems([.headerItem(CharacterListCellViewModel(marvelCharacter: marvelCharacter))],
                             toSection: .header)

        snapshot.appendSections([.personalInformation])
        snapshot.appendItems([.descriptionItem(marvelCharacter.description ?? L10n.Characters.emptyDescriptionPlaceholder)],
                             toSection: .personalInformation)

        guard !characterComics.isEmpty else { return snapshot }

        snapshot.appendSections([.comics])
        snapshot.appendItems(characterComics.map { CharacterDetailsSection.Item.comicsItem(CharacterComicCellViewModel(characterComic: $0)) },
                             toSection: .comics)

        return snapshot
    }
}
