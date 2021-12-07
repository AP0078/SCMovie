//
//  ImageViewExtension.swift
//  SCMovies
//
//  Created by Aung Phyoe on 7/12/21.
//

import Foundation
import UIKit
import Kingfisher
extension UIImageView {
    
    /// Cell Image Lazy Download
    ///
    /// - Parameters:
    ///   - link: Image url String
    ///   - downloadIfNew: true ? force download new if not cache : won't download only use cache
    ///   - completion: (String, Data?)
    /**
     ### Usage Example: ###
     ````
     self.imageView.lazyLoadImage(imageUrl,
     downloadIfNew: true) { [weak self](link, data) in
     if link == self?.imageUrl, let data = data {
     self?.imageView.image = UIImage(data: data)
     }
     }
     
     ````
     */
    func lazyLoadImage(_ link: String?,
                       completion: @escaping (String?, UIImage?) -> Void) {
        fill()
        guard let link = link else {
            completion(nil, nil)
            return
        }
        guard let url = URL(string: link ) else {
            return
        }
        let resource = ImageResource(downloadURL: url, cacheKey: url.absoluteString)
        
        // This should crash most devices due to memory pressure.
        // imageView.kf.setImage(with: resource)
        self.kf.indicatorType = .activity
        // This would survive on even the lowest spec devices!
        self.kf.setImage(
            with: resource,
            options: [
                .cacheOriginalImage
            ]
        ){ result in
            switch result {
            case .success(let value):
                completion(link, value.image)
            case .failure(_):
                 completion(link, nil)
            }
        }
    }
    
    /**
     /// it will works with bundle Image name or imageURL
     ### Usage Example: ###
     ````
     self.imageView.imageString = "close"
     self.imageView.imageString = "http://image.png"
     
     ````
     */
    
    func imageString(_ urlString: String?) {
        fill()
        guard let link = urlString else {
            return
        }
        if let image = UIImage(named: link) {
            self.image = image
            return
        }
        guard let url = URL(string: urlString ?? "") else {
            return
        }
        let resource = ImageResource(downloadURL: url, cacheKey: url.absoluteString)
        
        // This should crash most devices due to memory pressure.
        // imageView.kf.setImage(with: resource)
        self.kf.indicatorType = .activity
        
        // This would survive on even the lowest spec devices!
        self.kf.setImage(
            with: resource,
            options: [
                .cacheOriginalImage
            ]
        )
    }
    
}
extension UIImageView {
    
    func fill(with color: UIColor = .lightGray) {
        let size = self.bounds.size
        let image = UIGraphicsImageRenderer(size: size).image { rendererContext in
            color.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
        self.image = image
    }
}
