//
//  CharactersListViewModel.swift
//  Marvel
//
//  Created by Andrei Olteanu on 22.06.2022.
//

import Foundation
import Combine

protocol CharactersListFlowDelegate: AnyObject { }

protocol CharactersListViewModelInputs {
    func viewLoaded()
}

protocol CharactersListViewModelOutputs {
    var cellViewModels: [CharacterListCellViewModel] { get }
    var dataSourceChanged: AnyPublisher<Void, Never> { get }
}

protocol CharactersListViewModel {
    var inputs: CharactersListViewModelInputs { get }
    var outputs: CharactersListViewModelOutputs { get }
}

final class CharactersListViewModelImpl: CharactersListViewModel, CharactersListViewModelInputs, CharactersListViewModelOutputs {

    // MARK: - FlowDelegate

    weak var flowDelegate: CharactersListFlowDelegate?

    // MARK: - Inputs

    var inputs: CharactersListViewModelInputs { self }
    
    // MARK: - Outputs

    var outputs: CharactersListViewModelOutputs { self }

    var cellViewModels = [CharacterListCellViewModel]()

    var dataSourceChanged: AnyPublisher<Void, Never> {
        _dataSourceChanged.eraseToAnyPublisher()
    }

    // MARK: - Private Properties

    private let charactersService: CharactersService

    private let _dataSourceChanged = PassthroughSubject<Void, Never>()

    // MARK: - Init

    init(charactersService: CharactersService) {
        self.charactersService = charactersService
    }

    // MARK: - Public Methods

    func viewLoaded() {
        charactersService.getCharacters(offset: 0, limit: 20) { [weak self] result in
            switch result {
            case .success(let paginated):
                self?.cellViewModels = paginated.results.map { CharacterListCellViewModel(marvelCharacter: $0) }
                self?._dataSourceChanged.send(())
            case .failure(let error):
                print(error)
            }
        }
    }
}
