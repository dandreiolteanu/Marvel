//
//  CharacterComicCellViewModel.swift
//  Marvel
//
//  Created by Andrei Olteanu on 23.06.2022.
//

import Foundation

struct CharacterComicCellViewModel: Hashable {
    
    // MARK: - Public Properties

    let title: String
    let imageURL: URL?

    // MARK: - Private Properties

    private let id: MarvelComic.ID

    // MARK: - Init

    init(characterComic: MarvelComic) {
        self.id = characterComic.id
        self.title = characterComic.title ?? L10n.Characters.emptyComicTitlePlaceholder
        self.imageURL = characterComic.thumbnail?.url
    }
}
