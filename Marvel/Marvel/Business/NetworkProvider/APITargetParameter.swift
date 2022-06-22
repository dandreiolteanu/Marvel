//
//  APITargetParameter.swift
//  Marvel
//
//  Created by Andrei Olteanu on 21.06.2022.
//

import Foundation
import CryptoSwift

struct APITargetParameter<P: Encodable> {
    private let parameters: P
    private let timestamp: String
    private let hash: String
    private let apiKey: String

    init(_ parameters: P,
         timestamp: String = "\(Date().timeIntervalSince1970)",
         publicKey: String = APITarget.publicKey,
         privateKey: String = APITarget.privateKey) {
        self.parameters = parameters
        self.timestamp = timestamp
        self.hash = "\(timestamp)\(privateKey)\(publicKey)".md5()
        self.apiKey = publicKey
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
