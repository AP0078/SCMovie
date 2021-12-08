//
//  ExtensionTests.swift
//  SCMoviesTests
//
//  Created by Aung Phyoe on 8/12/21.
//

import XCTest
@testable import SCMovies

class ExtensionTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_view() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 150)))
        XCTAssertEqual(view.width, 100)
        XCTAssertEqual(view.height, 150)
        XCTAssertEqual(view.size, CGSize(width: 100, height: 150))
        
        view.width = 200
        view.height = 100
        XCTAssertEqual(view.width, 200)
        XCTAssertEqual(view.height, 100)
        
        view.size = CGSize(width: 300, height: 400)
        
        XCTAssertEqual(view.size, CGSize(width: 300, height: 400))
        
    }
    
    func test_dictionary() throws {
        
        let data = ["title" : "Movie reivew"]
        XCTAssertEqual(data.queryString, "title=Movie%20reivew")
    }
    
    func test_string() throws {
        
        XCTAssertEqual("True".bool, true)
        XCTAssertEqual("t".bool, true)
        XCTAssertEqual("yes".bool, true)
        XCTAssertEqual("y".bool, true)
        XCTAssertEqual("false".bool, false)
        XCTAssertEqual("f".bool, false)
        XCTAssertEqual("no".bool, false)
        XCTAssertEqual("n".bool, false)
        XCTAssertEqual("1".bool, true)
        XCTAssertEqual("0".bool, false)
        
        XCTAssertEqual("100".int , 100)
        XCTAssertEqual("50".int, 50)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
