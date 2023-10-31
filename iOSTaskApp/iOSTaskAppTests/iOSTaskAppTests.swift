//
//  iOSTaskAppTests.swift
//  iOSTaskAppTests
//
//  Created by Saravanan R on 25/10/23.
//

import XCTest
@testable import iOSTaskApp

final class iOSTaskAppTests: XCTestCase {
    
    var testObj: APIService?

    override func setUp() {
        super.setUp()
        testObj = APIService()
    }

    override func tearDown() {
        testObj = nil
        super.tearDown()
    }
    
    func test_fetch_newsarticles() {

        // Given A apiservice
        let apiService = self.testObj!

        // When fetch popular author
        let expect = XCTestExpectation(description: "author")

        apiService.fetchNewsData(complete: { (success, articles, error) in
            expect.fulfill()
            XCTAssertEqual( articles.count, 20)
            for article in articles {
                XCTAssertNotNil(article.id)
            }
        })
        wait(for: [expect], timeout: 3.1)
    }
}
