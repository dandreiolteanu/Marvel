//
//  EasterEggService.swift
//  Marvel
//
//  Created by Andrei Olteanu on 23.06.2022.
//

// MARK: - Typealiases

protocol EasterEggService {
    var hasEasterEgg: Bool { get }
}

struct ThorCharacterEasterEgg: EasterEggService {

    // MARK: - Public Properties

    let hasEasterEgg: Bool

    // MARK: - Init

    init(marvelCharacter: MarvelCharacter) {
        self.hasEasterEgg = marvelCharacter.name?.lowercased().contains("thor") ?? false
    }
}
