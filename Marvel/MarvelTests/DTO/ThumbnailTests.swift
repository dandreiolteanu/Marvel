//
//  ThumbnailTests.swift
//  MarvelTests
//
//  Created by Andrei Olteanu on 24.06.2022.
//

import XCTest
@testable import Marvel

class ThumbnailTests: XCTestCase {

    func testHasCorrectFinalURL() {
        let path = "https://test.com/213123"
        let `extension` = "jpg"
        let mock = Thumbnail(path: path, extension: `extension`)

        XCTAssertNotNil(mock.url)
        XCTAssertEqual(mock.url, URL(string: "\(path).\(`extension`)"))
    }
}
