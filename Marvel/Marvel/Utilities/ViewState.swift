//
//  ViewState.swift
//  Marvel
//
//  Created by Andrei Olteanu on 22.06.2022.
//

import Foundation
import UIKit

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

// MARK: - BackgroundView + FooterView

extension ViewState {
    var backgroundView: UIView? {
        switch self {
        case .loading(let loadingType):
            switch loadingType {
            case .normal:
                return LoadingView()
            case .nextPage:
                return nil
            }
        case .content:
            return nil
        case .empty(let message):
            return IconMessageLabelView(message: message ?? L10n.Reusable.emptyContent,
                                        icon: Asset.imgNavBar.image)
        case .error(let message):
            return IconMessageLabelView(message: message ?? L10n.Reusable.errorContent,
                                        icon: Asset.imgNavBar.image)
        }
    }

    var footerView: UIView? {
        guard case let .loading(loadingType) = self, loadingType == .nextPage else {
            return nil
        }

        return LoadingView()
    }
}
