//
//  CharacterListCellViewModel.swift
//  Marvel
//
//  Created by Andrei Olteanu on 22.06.2022.
//

import Foundation

struct CharacterListCellViewModel: Hashable {
    
    // MARK: - Public Properties

    let title: String
    let imageURL: URL?

    // MARK: - Private Properties

    private let id: MarvelCharacter.ID

    // MARK: - Init

    init(marvelCharacter: MarvelCharacter) {
        self.id = marvelCharacter.id
        self.title = marvelCharacter.name ?? L10n.Characters.emptyNamePlaceholder
        self.imageURL = marvelCharacter.thumbnail?.url
    }
}
