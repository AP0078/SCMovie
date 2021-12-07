//
//  RequestManager.swift
//  SCMovies
//
//  Created by Aung Phyoe on 7/12/21.
//

import Foundation
import UIKit

struct Response {
    let data: Data?
    let metadata: URLResponse?
}

enum URLError: Error {
    case invalidURL
    case generalError
}
///
class RequestManager: NSObject {
    
    static let shared = RequestManager()
    private var session: URLSession
    /// defaultTimeoutInterval is 90 sec
    static var defaultTimeoutInterval: TimeInterval = 90.0
    
    init(session: URLSession = .shared) {
        self.session = session
    }
     /// replaceSession eg. for MOCK data
    func replaceSession(session: URLSession = .shared) {
        self.session = session
    }
    
    /// GET NSMutableURLRequest
    ///
    /// - Parameters:
    ///   - url: url
    ///   - policy: policy default is URLRequest.CachePolicy
    ///   - timeoutInterval: session timeoutInterval
    /// - Returns: NSMutableURLRequest
    fileprivate func request(_ url: URL,
                                cache policy: URLRequest.CachePolicy,
                                timeoutInterval: TimeInterval) -> NSMutableURLRequest {
        
        let theRequest = NSMutableURLRequest(url: url, cachePolicy: policy, timeoutInterval: timeoutInterval)
        theRequest.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        return theRequest
    }
    
    /// GET request
    ///
    /// - Parameters:
    ///   - urlString: urlString
    ///   - header: [String: String] parameter
    ///   - policy: policy URLRequest.CachePolicy
    ///   - timeoutInterval: session timeoutInterval
    /// - Returns: NSMutableURLRequest
    /// - Throws: throws URLError
    fileprivate func getRequest(_ urlString: String,
                                header: [String: String]? = nil,
                                cache policy: URLRequest.CachePolicy,
                                timeoutInterval: TimeInterval)
        throws -> NSMutableURLRequest {
            guard let url = URL(string: urlString) else {
                throw URLError.invalidURL
            }
            let theRequest = self.request(url, cache: policy, timeoutInterval: timeoutInterval)
            theRequest.httpMethod = "GET"
            guard let parameter = header else {
                return theRequest
            }
            for (key, value) in parameter {
                theRequest.addValue(value, forHTTPHeaderField: key)
            }
            
        return theRequest
    }
    
    /// GET Request
    ///
    /// - Parameters:
    ///   - urlString: url String
    ///   - policy: cachePolicy Default is .reloadIgnoringLocalCacheData
    ///   - completion: completion Callback Result<Response, Error>
    func get(_ urlString: String,
             header: [String: String]? = nil,
             cache policy: URLRequest.CachePolicy = .reloadIgnoringLocalCacheData,
             timeoutInterval: TimeInterval = RequestManager.defaultTimeoutInterval,
             completion: @escaping (Result<Response, Error>) -> Void ) {
        do {
            let requestURL =   try self.getRequest(urlString,
                                                   header: header,
                                                   cache: policy,
                                                   timeoutInterval: timeoutInterval) as URLRequest
            let session = self.session
            session.dataTask(with: requestURL,
                             completionHandler: {(data, response, error) in
                                DispatchQueue.main.async {

                                    if let error  = error {
                                        completion(.failure(error))
                                        return
                                    }
                                    completion(.success(Response(data: data, metadata: response)))
                                }
            }).resume()
        } catch URLError.invalidURL {
           completion(.failure(URLError.invalidURL))
        } catch {
           completion(.failure(URLError.generalError))
        }
    }
}
