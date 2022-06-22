//
//  Environment.swift
//  Marvel
//
//  Created by Andrei Olteanu on 22.06.2022.
//

import Foundation

enum Environment {

    // MARK: - Cases

    case debug
    case release

    // MARK: - Public Properties

    var isDebug: Bool {
        self == .debug
    }

    var isRelease: Bool {
        self == .release
    }

    // MARK: - Static Properties

    static var current: Environment {
        #if DEBUG
            return .debug
        #else
            return .release
        #endif
    }
}
