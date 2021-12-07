//
//  Extension.swift
//  SCMovies
//
//  Created by Aung Phyoe on 7/12/21.
//

import Foundation

///String
extension String {
    
    var bool: Bool? {
        switch self.lowercased() {
        case "true", "t", "yes", "y":
            return true
        case "false", "f", "no", "n", "":
            return false
        default:
            if let int = Int(self) {
                return int != 0
            }
            return nil
        }
    }
}

extension Dictionary {
    
    var queryString: String {
        var output: String = ""
        for (key,value) in self {
            output +=  "\(key)=\(value)&"
        }
        output = String(output.dropLast())
        return output
    }
}

extension Data {
    /// JSONDecoder
    ///
    /// - Parameters:
    ///   - type: Decodable Type
    /// - Returns: Decodable Object
    /// - Example: let photos = Data.decode(Photos.self) as? Photos
    
    func decode<T: Decodable>(_ type: T.Type) -> Decodable? {
        return try? JSONDecoder().decode(T.self, from: self)
    }
}

