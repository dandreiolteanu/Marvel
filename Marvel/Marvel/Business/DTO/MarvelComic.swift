//
//  MarvelComic.swift
//  Marvel
//
//  Created by Andrei Olteanu on 23.06.2022.
//

import Foundation

struct MarvelComic: Identifiable {
    typealias ID = Int

    // MARK: - Public Properties

    let id: ID
    let title: String?
    let thumbnail: Thumbnail?
}

// MARK: - Encodable

extension MarvelComic: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case thumbnail
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        title = try container.decodeIfPresent(String.self, forKey: .title)?.nilIfEmpty
        thumbnail = try container.decodeIfPresent(Thumbnail.self, forKey: .thumbnail)
    }
}
