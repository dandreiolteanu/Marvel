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

    // MARK: - Init

    init(marvelCharacter: MarvelCharacter) {
        self.title = marvelCharacter.name
        self.imageURL = marvelCharacter.thumbnail.url
    }
}
