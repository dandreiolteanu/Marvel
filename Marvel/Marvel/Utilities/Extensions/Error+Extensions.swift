//
//  Error+Extensions.swift
//  Marvel
//
//  Created by Andrei Olteanu on 23.06.2022.
//

import Foundation
import Alamofire
import Moya

extension Error {

    // MARK: - Public Properties

    var isCancel: Bool {
        // I was curious about using Moya + Alamofire because I like how Moya is made, but for cases such as this I don't like it.
        // I was previously using a custom NetworkClient made by me, but gave Moya a shot
        guard case let .underlying(error, _) = self as? MoyaError else { return false }

        return error.asAFError?.isExplicitlyCancelledError ?? false
    }
}
