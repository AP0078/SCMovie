//
//  SearchViewModel.swift
//  SCMovies
//
//  Created by Aung Phyoe on 7/12/21.
//

import Foundation

enum SearchError: Error {
    case error(String)
}

class SearchViewModel: BaseViewModel {
    
    override init(_ delegate: ViewModelDelegate? = nil) {
        super.init(delegate)
        self.delegate = delegate
    }
  
    private var currentPage: Int = 1
    private var totalResults: Int = 0
    
    var dataSource = [Search]()
    
    var searchString: String?
    
    private func hasNextPage() -> Bool {
        if totalResults > dataSource.count {
            return true
        }
        return false
    }
    
    func loadPaging() {
        if hasNextPage(){
            if self.loading {return}
            loadData(true)
        }
    }
    func loadData(_ paging: Bool = false) {
        
        guard let title = searchString, title.count > 2 else {
            dataSource.removeAll()
            currentPage = 1
            self.failure(error: SearchError.error("Type Min 3 words"))
            return
        }
        
        if paging {
            currentPage += 1
        } else {
            dataSource.removeAll()
            currentPage = 1
        }
       let service = APIManager()
        self.loading = true
        service.search(title: title, page: currentPage) { [weak self]results in
            self?.loading = false
            switch results {
            case .success(let response):
                let success = response?.gotResult ?? false
                if  !success {
                    self?.failure(error: SearchError.error(response?.error ?? "Unknown error"))
                    return
                }
                self?.totalResults = response?.totalResults?.int ?? 0
                if let list = response?.search, !list.isEmpty {
                    self?.dataSource.append(contentsOf: list)
                }
                self?.success()
            case .failure(let error):
                self?.failure(error: SearchError.error(error.localizedDescription))
            }
        }
    }
}
