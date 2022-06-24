//
//  CharacterListCellViewModelTests.swift
//  MarvelTests
//
//  Created by Andrei Olteanu on 24.06.2022.
//

import XCTest
@testable import Marvel

class CharacterListCellViewModelTests: XCTestCase {

    func testHasTitle() {
        let mock = MarvelCharacter(id: 123, name: "Batman", description: nil, thumbnail: nil)
        let cellViewModel = CharacterListCellViewModel(marvelCharacter: mock)

        XCTAssertEqual(cellViewModel.title, mock.name)
    }

    func testNoTitleAvailable() {
        let mock = MarvelCharacter(id: 123, name: nil, description: nil, thumbnail: nil)
        let cellViewModel = CharacterListCellViewModel(marvelCharacter: mock)

        XCTAssertEqual(cellViewModel.title, L10n.Characters.emptyNamePlaceholder)
    }
}
