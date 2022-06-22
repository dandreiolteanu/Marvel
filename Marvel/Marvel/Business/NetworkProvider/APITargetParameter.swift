//
//  APITargetParameter.swift
//  Marvel
//
//  Created by Andrei Olteanu on 21.06.2022.
//

import Foundation
import CryptoSwift

struct APITargetParameter<P: Encodable> {

    // MARK: - Private Properties

    private let parameters: P
    private let timestamp: String
    private let hash: String
    private let apiKey: String

    // MARK: - Init

    init(_ parameters: P) {
        self.parameters = parameters
        self.timestamp = "\(Date().timeIntervalSince1970)"
        self.hash = "\(timestamp)\(APITarget.privateKey)\(APITarget.publicKey)".md5()
        self.apiKey = APITarget.publicKey
    }
}

// MARK: - Encodable

extension APITargetParameter: Encodable {

    enum CodingKeys: String, CodingKey {
        case parameters
        case timestamp = "ts"
        case hash
        case apiKey = "apikey"
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try parameters.encode(to: encoder)
        try container.encode(timestamp, forKey: .timestamp)
        try container.encode(hash, forKey: .hash)
        try container.encode(apiKey, forKey: .apiKey)
    }
}
