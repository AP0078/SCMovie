//
//  Extension.swift
//  SCMovies
//
//  Created by Aung Phyoe on 7/12/21.
//

import Foundation
import UIKit

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
    
    var int: Int {
        if let myNumber = NumberFormatter().number(from: "\(self)") {
            return myNumber.intValue
          } else {
            return 0
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
        return output.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? output
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

extension UIApplication {

    var keyWindow: UIWindow? {
        return self.windows.filter {$0.isKeyWindow}.first
    }
    
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
            
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return topViewController(base: selected)
            
        } else if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
    
    class func topController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let tab = base as? UITabBarController {
            return tab
            
        } else if let nav = base as? UINavigationController {
            return nav.topViewController
            
        }   else if let presented = base?.presentedViewController {
            return presented
        }
        return base
    }
}

extension UIView {
    
    /// Size of view.
    var size: CGSize {
        get {
            return self.frame.size
        }
        set {
            self.width = newValue.width
            self.height = newValue.height
        }
    }
    
    /// Width of view.
    var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            self.frame.size.width = newValue
        }
    }
    
    /// Height of view.
    var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            self.frame.size.height = newValue
        }
    }
}
