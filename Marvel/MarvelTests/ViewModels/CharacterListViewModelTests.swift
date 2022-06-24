//
//  CharacterListViewModelTests.swift
//  MarvelTests
//
//  Created by Andrei Olteanu on 24.06.2022.
//

import XCTest
@testable import Marvel
import Combine

class CharacterListViewModelTests: XCTestCase {

    // MARK: - Private Properties

    private var subscriptions = Set<AnyCancellable>()

    // MARK: - TestCases

    func testInitialState() {
        let mock = CharactersServiceMock(result: .failure(APIErrorMock.notAvailable))
        let viewModel = CharactersListViewModelImpl(charactersService: mock)

        let expectation = expectationFrom(publisher: viewModel.viewState, cancellables: &subscriptions) { state in
            XCTAssertEqual(state, .loading(.normal))
        }

        wait(for: [expectation], timeout: 0.1)
    }

    func testErrorState() {
        let mock = CharactersServiceMock(result: .failure(APIErrorMock.notAvailable))
        let viewModel = CharactersListViewModelImpl(charactersService: mock)

        viewModel.viewLoaded()

        let expectation = expectationFrom(publisher: viewModel.viewState, cancellables: &subscriptions) { state in
            XCTAssertEqual(state, .error)
        }

        wait(for: [expectation], timeout: 0.1)
    }

    func testEmptyState() {
        let mock = CharactersServiceMock(result: .success(MarvelPaginatedResult<MarvelCharacter>(offset: 0, limit: 10, total: 100, count: 10, results: [])))
        let viewModel = CharactersListViewModelImpl(charactersService: mock)

        viewModel.viewLoaded()

        let expectation = expectationFrom(publisher: viewModel.viewState, cancellables: &subscriptions) { state in
            XCTAssertEqual(state, .empty)
        }

        wait(for: [expectation], timeout: 0.1)
    }

    func testContentState() {
        let characters = [MarvelCharacter(id: 123, name: "Batman", description: nil, thumbnail: nil)]
        let mock = CharactersServiceMock(result: .success(MarvelPaginatedResult<MarvelCharacter>(offset: 0, limit: 10, total: 100, count: 10, results: characters)))
        let viewModel = CharactersListViewModelImpl(charactersService: mock)

        viewModel.viewLoaded()

        let expectation = expectationFrom(publisher: viewModel.viewState, cancellables: &subscriptions) { state in
            XCTAssertEqual(state, .content)
        }

        wait(for: [expectation], timeout: 0.1)
    }

    func testNextPageOffset() {
        let offset = 0
        let limit = 10
        let total = 100
        let count = 10
        let mock = CharactersServiceMock(result: .success(MarvelPaginatedResult<MarvelCharacter>(offset: offset, limit: limit, total: total, count: count, results: [])))
        let viewModel = CharactersListViewModelImpl(charactersService: mock)

        viewModel.viewLoaded()

        XCTAssertEqual(viewModel.nextOffset, offset + limit)
    }
}
