//
//  MovieDetailViewController.swift
//  SCMovies
//
//  Created by Aung Phyoe on 7/12/21.
//

import UIKit
import Reusable

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.accessibilityIdentifier = "detail_movie_result"
            collectionView.register(cellType: MovieDetailCell.self)
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    @IBOutlet weak var messageLabel: UILabel!{
        didSet {
            messageLabel.isHidden = true
        }
    }
    var imdbID: String?
    var viewModel: MovieDetailViewModel!
    let padding: CGFloat = 5

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movie Detail"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.viewModel = MovieDetailViewModel(self)
        if let imdbID = imdbID {
            self.viewModel.loadData(imdbID)
        }
    }
}

extension MovieDetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.dataSource == nil ? 0 : 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MovieDetailCell = collectionView.dequeueReusableCell(for: indexPath)
        if let data = self.viewModel.dataSource {
            cell.loadData(data)
        }
        return cell
    }
}
extension MovieDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
// MARK:- UICollectionViewDelegateFlowLayout methods
extension MovieDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.width
        return CGSize(width: width, height: width * 1.7)
    }
}
extension MovieDetailViewController: ViewModelDelegate {
    func onSuccess() {
        messageLabel.text = ""
        messageLabel.isHidden = true
        self.collectionView.reloadData()
    }
    
    func onFailure(error: Error?) {
        if let error = error as? SearchError {
            switch error {
            case .error(let string):
                messageLabel.text = string
            }
        } else {
            messageLabel.text = error?.localizedDescription
        }
        messageLabel.isHidden = false
        self.collectionView.reloadData()
    }
    
    func isLoading(loading: Bool) {
        if loading {
            LoadingManager.share.showLoading(self.view)
        } else {
            LoadingManager.share.stopLoading()
        }
    }
    
}
