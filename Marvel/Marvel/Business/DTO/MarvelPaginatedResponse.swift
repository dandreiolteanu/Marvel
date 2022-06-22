//
//  MarvelPaginatedResponse.swift
//  Marvel
//
//  Created by Andrei Olteanu on 22.06.2022.
//

import Foundation

struct MarvelPaginatedResult<T: Decodable>: Decodable {

    // MARK: - Public Properties

    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [T]

    var hasMorePages: Bool {
        offset + count < total
    }

    var nextOffset: Int {
        hasMorePages ? offset + limit : offset
    }
}
