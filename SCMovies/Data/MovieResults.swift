//
//  MovieResults.swift
//  SCMovies
//
//  Created by Aung Phyoe on 7/12/21.
//

import Foundation
// MARK: - MovieResults
struct MovieResults: Codable {
    let search: [Search]?
    let totalResults: String?
    let response: String?
    let error: String?
    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
        case error = "Error"
    }
    var gotResult: Bool? {
        return response?.bool
    }
}

// MARK: - Search
struct Search: Codable {
    let title, year, imdbID: String?
    let type: TypeEnum?
    let poster: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}

enum TypeEnum: String, Codable {
    case movie = "movie"
}
