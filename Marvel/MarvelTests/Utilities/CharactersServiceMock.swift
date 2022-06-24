//
//  MockService.swift
//  MarvelTests
//
//  Created by Andrei Olteanu on 24.06.2022.
//

@testable import Marvel
import Moya

final class CharactersServiceMock: CharactersService {

    // MARK: - Public Properties

    var result: Result<MarvelPaginatedResult<MarvelCharacter>, Error>

    // MARK: - Init

    init(result: Result<MarvelPaginatedResult<MarvelCharacter>, Error>) {
        self.result = result
    }

    // MARK: - CharactersService

    func getCharacters(offset: Int, limit: Int, query: String?, completion: @escaping CharactersResult) -> Cancellable {
        completion(result)

        return CancellableWrapperMock()
    }
}
