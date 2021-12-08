//
//  MockData.swift
//  SCMoviesTests
//
//  Created by Aung Phyoe on 8/12/21.
//

import Foundation
@testable import SCMovies

enum MockError: Error {
    case fileNotFound
}

class MockData {
    static let baseURL = "http://www.omdbapi.com"
        
    static fileprivate func getData(filename: String) -> Data? {
        let bundle = Bundle(for: MockData.self)
        guard let jsonURL = bundle.url(forResource: filename, withExtension: "json") else {
        return nil
        }
        let data = try? Data(contentsOf: jsonURL)
        return data
    }
    
    static func getMovieDetailData() -> MovieDetails? {
        return self.getData(filename: "moviedetail")?.decode(MovieDetails.self) as? MovieDetails
    }
    
    static func getMovieListData() -> [Search]? {
        if let results = self.getData(filename: "movielist")?.decode(MovieResults.self) as? MovieResults {
            return results.search
        }
        return nil
    }
    
}
