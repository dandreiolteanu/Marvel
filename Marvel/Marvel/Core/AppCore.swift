//
//  AppCore.swift
//  Marvel
//
//  Created by Andrei Olteanu on 21.06.2022.
//

import Foundation

final class AppCore {

    // MARK: - Public Properties

    var characterComicsService: CharacterComicsService
    var charactersService: CharactersService

    // MARK: - Private Properties

    private let networkProvider: NetworkProvider<APITarget>

    // MARK: - Init

    init() {
        self.networkProvider = NetworkProvider<APITarget>()
        self.characterComicsService = CharacterComicsServiceImpl(networkProvider: networkProvider)
        self.charactersService = CharactersServiceImpl(networkProvider: networkProvider)
    }
}
