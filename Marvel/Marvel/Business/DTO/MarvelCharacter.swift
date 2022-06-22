//
//  MarvelCharacter.swift
//  Marvel
//
//  Created by Andrei Olteanu on 22.06.2022.
//

import Foundation

struct MarvelCharacter: Decodable {

    // MARK: - Public Properties

    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail
}
