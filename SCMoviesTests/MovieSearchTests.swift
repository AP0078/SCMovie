//
//  MovieSearchTests.swift
//  SCMoviesTests
//
//  Created by Aung Phyoe on 8/12/21.
//

import XCTest
@testable import SCMovies

class MovieSearchTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_movie_search() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        let storyboard = UIStoryboard(name: "Movie", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else {
            assertionFailure("")
            return
        }
        controller.loadView()
        controller.viewDidLoad()
        guard let cell = controller.collectionView(controller.collectionView, cellForItemAt: IndexPath(row: 0, section: 0)) as? MovieListCell else {
            
            assertionFailure("")
            return
        }
        
        cell.awakeFromNib()
        if let data = MockData.getMovieListData(), let movie = data.first {
            cell.loadData(movie.title, imageUrl: movie.poster)
        }
        
        XCTAssertEqual(cell.titleLabel.text, "Captain Marvel")
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
