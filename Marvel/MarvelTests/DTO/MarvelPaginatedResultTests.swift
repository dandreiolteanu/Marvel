//
//  MarvelPaginatedResultTests.swift
//  MarvelTests
//
//  Created by Andrei Olteanu on 22.06.2022.
//

import XCTest
@testable import Marvel

class MarvelPaginatedResultTests: XCTestCase {

    func testHasMorePages() {
        let mock = MarvelPaginatedResult<Int>(offset: 0, limit: 10, total: 100, count: 10, results: [])

        XCTAssertEqual(mock.hasMorePages, true)
    }

    func testNextOffset() {
        let offset = 0
        let limit = 10
        let total = 100
        let count = 10
        let mock = MarvelPaginatedResult<Int>(offset: offset, limit: limit, total: total, count: count, results: [])

        XCTAssertEqual(mock.nextOffset, offset + limit)
    }
}
