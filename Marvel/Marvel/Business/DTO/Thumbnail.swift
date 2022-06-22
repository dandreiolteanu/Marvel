//
//  Thumbnail.swift
//  Marvel
//
//  Created by Andrei Olteanu on 22.06.2022.
//

import Foundation

struct Thumbnail: Decodable {

    // MARK: - Public Properties

    var url: URL? { URL(string: "\(path).\(`extension`)") }

    // MARK: - Private Properties

    private let path: String
    private let `extension`: String

    // MARK: - Init

    init(path: String, extension: String) {
        self.path = path
        self.extension = `extension`
    }
}
