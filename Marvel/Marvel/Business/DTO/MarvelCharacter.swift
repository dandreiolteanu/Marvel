//
//  MarvelCharacter.swift
//  Marvel
//
//  Created by Andrei Olteanu on 22.06.2022.
//

import Foundation

struct MarvelCharacter: Identifiable {
    typealias ID = Int

    // MARK: - Public Properties

    let id: ID
    let name: String?
    let description: String?
    let thumbnail: Thumbnail?
}

// MARK: - Encodable

extension MarvelCharacter: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case thumbnail
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)?.nilIfEmpty
        description = try container.decodeIfPresent(String.self, forKey: .description)?.nilIfEmpty
        thumbnail = try container.decodeIfPresent(Thumbnail.self, forKey: .thumbnail)
    }
}
