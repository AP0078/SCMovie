//
//  MovieListCell.swift
//  SCMovies
//
//  Created by Aung Phyoe on 7/12/21.
//

import UIKit
import Reusable

class MovieListCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    private var imageUrl: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadData(_ title: String?, imageUrl: String?) {
        self.titleLabel.text = title
        self.imageUrl = imageUrl
        self.avatarImageView.lazyLoadImage(imageUrl) {[weak self] (link, image) in
            self?.avatarImageView.image = image
        }
    }
}
