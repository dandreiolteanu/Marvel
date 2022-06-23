//
//  CharacterComicsService.swift
//  Marvel
//
//  Created by Andrei Olteanu on 23.06.2022.
//

import Moya

// MARK: - Typealiases

typealias CharacterComicsResult = (Result<MarvelPaginatedResult<MarvelComic>, Error>) -> Void

protocol CharacterComicsService {
    @discardableResult func getComics(marvelCharacterId: MarvelCharacter.ID, completion: @escaping CharacterComicsResult) -> Cancellable
}

final class CharacterComicsServiceImpl: CharacterComicsService {

    // MARK: - Private Properties

    private let networkProvider: NetworkProvider<APITarget>

    // MARK: - Init

    init(networkProvider: NetworkProvider<APITarget>) {
        self.networkProvider = networkProvider
    }

    // MARK: - Public Methods

    @discardableResult func getComics(marvelCharacterId: MarvelCharacter.ID, completion: @escaping CharacterComicsResult) -> Cancellable {
        networkProvider.request(.characterComics(marvelCharacterId), for: MarvelResponse<MarvelComic>.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
