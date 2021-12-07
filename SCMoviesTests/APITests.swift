//
//  APITest.swift
//  SCMoviesTests
//
//  Created by Aung Phyoe on 7/12/21.
//

import XCTest
@testable import SCMovies

class APITest: XCTestCase {
    var service: APIManager?
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        service = APIManager()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        service = nil
    }

    func test_search_success() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let expectation = self.expectation(description: "search")
        service?.search(title: "Marvel") { results in
            switch results {
            case .success(let response):
                XCTAssertEqual(response?.gotResult, true)
                expectation.fulfill()
            case .failure(let error):
                XCTAssertNil(error)
                expectation.fulfill()
 
            }
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func test_search_fail() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let expectation = self.expectation(description: "search")
        service?.search(title: "Ma") { results in
            switch results {
            case .success(let response):
                XCTAssertEqual(response?.gotResult, false)
                expectation.fulfill()
            case .failure(let error):
                XCTAssertNil(error)
                expectation.fulfill()
 
            }
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func test_detail_success() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let expectation = self.expectation(description: "search")
        service?.detail(imdbID: "tt4154664") { results in
            switch results {
            case .success(let response):
                XCTAssertEqual(response?.gotResult, true)
                expectation.fulfill()
            case .failure(let error):
                XCTAssertNil(error)
                expectation.fulfill()
 
            }
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    func test_detail_fail() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let expectation = self.expectation(description: "search")
        service?.detail(imdbID: "tt4") { results in
            switch results {
            case .success(let response):
                XCTAssertEqual(response?.gotResult, false)
                expectation.fulfill()
            case .failure(let error):
                XCTAssertNil(error)
                expectation.fulfill()
 
            }
        }
        waitForExpectations(timeout: 3, handler: nil)
    }

}
