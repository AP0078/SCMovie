//
//  MovieDetailCell.swift
//  SCMovies
//
//  Created by Aung Phyoe on 7/12/21.
//

import UIKit
import Reusable

class MovieDetailCell: UICollectionViewCell, NibReusable {
    
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var ratedLabel: UILabel!
    @IBOutlet weak var imdbRatingLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var actorLabel: UILabel!
    @IBOutlet weak var imdbVotesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadData(_ data: MovieDetails) {
        titleLabel.text = data.title
        avatarImageView.imageString(data.poster)
        yearLabel.text = data.year
        genreLabel.text = data.genre
        runtimeLabel.text = data.runtime
        ratedLabel.text = data.rated
        imdbRatingLabel.text = "⭐ \(data.imdbRating ?? "")"
        plotLabel.text = data.plot
        scoreLabel.text = data.metascore
        imdbVotesLabel.text = data.imdbVotes
        directorLabel.text = data.director
        writerLabel.text = data.writer
        actorLabel.text = data.actors
    }

}
