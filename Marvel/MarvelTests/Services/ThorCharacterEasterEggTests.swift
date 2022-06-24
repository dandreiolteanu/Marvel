//
//  ThorCharacterEasterEggTests.swift
//  MarvelTests
//
//  Created by Andrei Olteanu on 24.06.2022.
//

import XCTest
@testable import Marvel

class ThorCharacterEasterEggTests: XCTestCase {

    func testEasterEggEnabled() {
        let thor = MarvelCharacter(id: 123, name: "Thor", description: nil, thumbnail: nil)
        let service = ThorCharacterEasterEgg(marvelCharacter: thor)

        XCTAssertEqual(service.hasEasterEgg, true)
    }

    func testEasterEggEnabledNameContainsThor() {
        let thor = MarvelCharacter(id: 123, name: "Thor, the mjolnir batman", description: nil, thumbnail: nil)
        let service = ThorCharacterEasterEgg(marvelCharacter: thor)

        XCTAssertEqual(service.hasEasterEgg, true)
    }

    func testEasterEggDisabled() {
        let thor = MarvelCharacter(id: 123, name: "Spider-man", description: nil, thumbnail: nil)
        let service = ThorCharacterEasterEgg(marvelCharacter: thor)

        XCTAssertEqual(service.hasEasterEgg, false)
    }
}
