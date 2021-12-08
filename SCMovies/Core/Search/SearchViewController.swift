//
//  SearchViewController.swift
//  SCMovies
//
//  Created by Aung Phyoe on 7/12/21.
//

import UIKit
import Reusable

class SearchViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.accessibilityIdentifier = "list_movie_result"
            collectionView.register(cellType: MovieListCell.self)
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    @IBOutlet weak var messageLabel: UILabel!{
        didSet {
            messageLabel.isHidden = true
        }
    }
    
    var viewModel: SearchViewModel!
    let padding: CGFloat = 5
    
    lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.searchBar.delegate = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search Movie Title"
        return search
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movie List"
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.searchController = self.searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.viewModel = SearchViewModel(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetail" {
            if let viewController = segue.destination as? MovieDetailViewController {
                if let imdbID = sender as? String {
                    viewController.imdbID = imdbID
                }
            }
        }
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.dataSource.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MovieListCell = collectionView.dequeueReusableCell(for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let datacell = cell as? MovieListCell {
            let movie = self.viewModel.dataSource[indexPath.row]
            datacell.loadData(movie.title, imageUrl: movie.poster)
        }
        let count = self.viewModel.dataSource.count
        if indexPath.row == count - 2 {  //numberofitem count
            self.viewModel?.loadPaging()
        }
        
    }
}
extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = self.viewModel.dataSource[indexPath.row]
        self.performSegue(withIdentifier: "segueDetail", sender: movie.imdbID)
    }
}
// MARK:- UICollectionViewDelegateFlowLayout methods
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.width / 2) - padding * 2
        return CGSize(width: width, height: width * 1.5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    @objc(collectionView:layout:minimumLineSpacingForSectionAtIndex:) func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return padding
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return  CGSize.zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    }
}
extension SearchViewController: ViewModelDelegate {
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

extension SearchViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel?.searchString = nil
        self.viewModel?.loadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
         self.viewModel?.loadData()
    }
}

extension SearchViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            self.viewModel?.searchString = text.trimmingCharacters(in: .whitespaces)
        } else {
            self.viewModel?.searchString = nil
        }
    }
}
