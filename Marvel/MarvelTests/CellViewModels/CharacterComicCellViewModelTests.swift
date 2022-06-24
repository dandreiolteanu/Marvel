//
//  CharacterComicCellViewModelTests.swift
//  MarvelTests
//
//  Created by Andrei Olteanu on 24.06.2022.
//

import XCTest
@testable import Marvel

class CharacterComicCellViewModelTests: XCTestCase {

    func testHasTitle() {
        let mock = MarvelComic(id: 123, title: "Batman vs Superman", thumbnail: nil)
        let cellViewModel = CharacterComicCellViewModel(characterComic: mock)

        XCTAssertEqual(cellViewModel.title, mock.title)
    }

    func testNoTitleAvailable() {
        let mock = MarvelComic(id: 123, title: nil, thumbnail: nil)
        let cellViewModel = CharacterComicCellViewModel(characterComic: mock)

        XCTAssertEqual(cellViewModel.title, L10n.Characters.emptyComicTitlePlaceholder)
    }
}
