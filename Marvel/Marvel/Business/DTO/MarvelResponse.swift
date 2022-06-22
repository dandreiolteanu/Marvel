//
//  MarvelResponse.swift
//  Marvel
//
//  Created by Andrei Olteanu on 22.06.2022.
//

import Foundation

struct MarvelResponse<T: Decodable>: Decodable {

    // MARK: - Public Properties

    let data: MarvelPaginatedResult<T>
}
