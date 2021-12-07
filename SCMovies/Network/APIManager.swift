//
//  APIManager.swift
//  SCMovies
//
//  Created by Aung Phyoe on 7/12/21.
//

import Foundation
///
class APIManager: RequestManager {
    static let APIkey = "b9bd48a6"
    static let baseURL = "http://www.omdbapi.com"
    override init(session: URLSession = .shared) {
        super.init(session: session)
    }
  func completeSearch(title: String,
                      page: Int,
                      apiKey: String) -> String {
      
      let data = ["apikey" : apiKey,
                  "s" : title,
                  "page": "\(page)",
                  "type": "movie"]
      
      return String(format: "%@/?%@",APIManager.baseURL,  data.queryString)
  }
    func completeDetail(imdbID: String,
                        apiKey: String) -> String {
        
        let data = ["apikey" : apiKey,
                    "i" : imdbID]
        
        return String(format: "%@/?%@",APIManager.baseURL, data.queryString)
    }
}

//MARK: Public
extension APIManager {
    
    /// search
    ///
    /// - Parameters:
    ///   - title: String
    ///   - page: Int
    ///   - apiKey: String
    ///   - completion: success ? Result : error
    func search(title: String,
                page: Int = 1,
                apiKey: String = APIManager.APIkey,
                completion: @escaping (Result<MovieResults?, Error>) -> Void ) {

        self.get(completeSearch(title: title, page: page, apiKey: apiKey)) {(results) in
            switch results {
            case .success(let response):
                if let data = response.data {
                    if let data = data.decode(MovieResults.self) as? MovieResults {
                        
                        completion(.success(data))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    /// details
    ///
    /// - Parameters:
    ///   - imdbID: String
    ///   - apiKey: String
    ///   - completion: success ? Result : error
    func detail(imdbID: String,
                apiKey: String = APIManager.APIkey,
                completion: @escaping (Result<MovieDetails?, Error>) -> Void ) {

        self.get(completeDetail(imdbID: imdbID, apiKey: apiKey)) {(results) in
            switch results {
            case .success(let response):
                if let data = response.data {
                    if let data = data.decode(MovieDetails.self) as? MovieDetails {
                        completion(.success(data))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
