//
//  CharacterParameters.swift
//  Marvel
//
//  Created by Andrei Olteanu on 21.06.2022.
//

import Foundation

struct CharacterParameters: Encodable {

    // MARK: - Private Properties

    private let offset: Int
    private let limit: Int
    private let nameStartsWith: String?

    // MARK: - Init

    init(offset: Int = 0, limit: Int = 10, query: String? = nil) {
        self.offset = offset
        self.limit = limit
        self.nameStartsWith = query?.nilIfEmpty
    }
}
