//
//  APIErrorMock.swift
//  MarvelTests
//
//  Created by Andrei Olteanu on 24.06.2022.
//

import Foundation

enum APIErrorMock: Error {

    // MARK: - Cases

    case notAvailable

    // MARK: - Public Properties

    var localizedDescription: String {
        "Not available"
    }
}
