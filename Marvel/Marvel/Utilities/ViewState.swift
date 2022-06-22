//
//  ViewState.swift
//  Marvel
//
//  Created by Andrei Olteanu on 22.06.2022.
//

import Foundation

enum ViewState {

    // MARK: - LoadingType

    enum LoadingType {

        // MARK: - Cases

        case normal
        case nextPage
    }

    // MARK: - Cases
 
    case loading(LoadingType)
    case content
    case empty(String?)
    case error(String?)

    // MARK: - Static Properties

    static let loading: ViewState = .loading(.normal)
    static let empty: ViewState = .empty(nil)
    static let error: ViewState = .error(nil)
}

// MARK: - Equatable

extension ViewState: Equatable {
    static func == (lhs: ViewState, rhs: ViewState) -> Bool {
        switch (lhs, rhs) {
        case (.loading(let lhsType), .loading(let rhsType)):
            return lhsType == rhsType
        case (.content, .content):
            return true
        case (.empty(let lhsDescriprion), .empty(let rhsDescriprion)):
            return lhsDescriprion == rhsDescriprion
        case (.error(let lhsErrorDescription), .error(let rhsErrorDescription)):
            return lhsErrorDescription == rhsErrorDescription
        default:
            return false
        }
    }
}
