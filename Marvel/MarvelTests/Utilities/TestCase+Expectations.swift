//
//  TestCase+Expectations.swift
//  MarvelTests
//
//  Created by Andrei Olteanu on 24.06.2022.
//

import XCTest
import Combine

extension XCTestCase {
    func expectationFrom<T: Publisher>(publisher: T?,
                                       cancellables: inout Set<AnyCancellable>,
                                       onReceiveValue: @escaping (T.Output) -> Void = { _ in }) -> XCTestExpectation where T.Failure == Never {
        let exp = expectation(description: "Expectation for publisher -> " + String(describing: publisher))
        
        publisher?.sink { (output: T.Output) in
            onReceiveValue(output)
            exp.fulfill()
        }.store(in: &cancellables)
        
        return exp
    }
}
