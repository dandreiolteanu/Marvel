//
//  AppCore.swift
//  Marvel
//
//  Created by Andrei Olteanu on 21.06.2022.
//

import Foundation

final class AppCore {

    // MARK: - Public Properties

    var characteresService: CharactersService

    // MARK: - Init

    init() {
        let networkProvider: NetworkProvider<APITarget> = NetworkProvider<APITarget>()

        self.characteresService = CharactersServiceImpl(networkProvider: networkProvider)
    }
}
