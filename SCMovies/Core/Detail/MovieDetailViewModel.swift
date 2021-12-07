//
//  MovieDetailViewModel.swift
//  SCMovies
//
//  Created by Aung Phyoe on 7/12/21.
//

import Foundation

class MovieDetailViewModel: BaseViewModel {
    
    var dataSource: MovieDetails?
    
    func loadData(_ imdbID: String) {

       let service = APIManager()
        self.loading = true
        service.detail(imdbID: imdbID) { [weak self]results in
            self?.loading = false
            switch results {
            case .success(let response):
                let success = response?.gotResult ?? false
                if  !success {
                    self?.failure(error: SearchError.error(response?.error ?? "Unknown error"))
                    return
                }
                self?.dataSource = response
                self?.success()
            case .failure(let error):
                self?.failure(error: SearchError.error(error.localizedDescription))
            }
        }
    }
}
