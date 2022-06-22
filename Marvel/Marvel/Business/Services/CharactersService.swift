//
//  CharactersService.swift
//  Marvel
//
//  Created by Andrei Olteanu on 22.06.2022.
//

import Moya

// MARK: - Typealiases

typealias CharactersResult = (Result<MarvelPaginatedResult<MarvelCharacter>, Error>) -> Void

protocol CharactersService {
    @discardableResult func getCharacters(offset: Int, limit: Int, completion: @escaping CharactersResult) -> Cancellable
    @discardableResult func getCharacters(offset: Int, limit: Int, query: String?, completion: @escaping CharactersResult) -> Cancellable
}

final class CharactersServiceImpl: CharactersService {

    // MARK: - Private Properties

    private let networkProvider: NetworkProvider<APITarget>

    // MARK: - Init

    init(networkProvider: NetworkProvider<APITarget>) {
        self.networkProvider = networkProvider
    }

    // MARK: - Public Methods

    @discardableResult func getCharacters(offset: Int, limit: Int, completion: @escaping CharactersResult) -> Cancellable {
        getCharacters(offset: offset, limit: limit, query: nil, completion: completion)
    }

    @discardableResult func getCharacters(offset: Int, limit: Int, query: String?, completion: @escaping CharactersResult) -> Cancellable {
        networkProvider.request(.characters(CharacterParameters(offset: offset, limit: limit, query: query)), for: MarvelResponse<MarvelCharacter>.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
