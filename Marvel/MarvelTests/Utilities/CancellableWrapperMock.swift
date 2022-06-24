//
//  CancellableWrapperMock.swift
//  MarvelTests
//
//  Created by Andrei Olteanu on 24.06.2022.
//

import Moya

final class CancellableWrapperMock: Cancellable {

    // MARK: - Public Properties
    var isCancelled = false

    // MARK: - Public Methods

    func cancel() {
        isCancelled = true
    }
}
