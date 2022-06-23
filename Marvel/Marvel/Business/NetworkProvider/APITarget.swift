//
//  APITarget.swift
//  Marvel
//
//  Created by Andrei Olteanu on 21.06.2022.
//

import Foundation
import CryptoSwift
import Moya

enum APITarget {

    // MARK: - Cases

    case characters(CharacterParameters)
    case characterComics(MarvelCharacter.ID)

    // MARK: - Static Properties

    static let base = URL(string: "https://gateway.marvel.com/v1/public")!
    static let publicKey = "9929f1645b2e548ef8e0060cc7067534"
    static let privateKey = "8501a40c8e578ad2e055750b98141abc7e37e389"
}

// MARK: - Moya.TargetType

extension APITarget: Moya.TargetType {
    var baseURL: URL {
        APITarget.base
    }
    
    var path: String {
        switch self {
        case .characters:
            return "/characters"
        case .characterComics(let characterId):
            return "/characters/\(characterId)/comics"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .characters,
             .characterComics:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .characters(let params):
            return .requestParameters(parameters: APITargetParameter(params).toJSON(), encoding: URLEncoding.default)
        case .characterComics:
            return .requestParameters(parameters: APITargetParameter(EmptyParameters()).toJSON(), encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }
}
