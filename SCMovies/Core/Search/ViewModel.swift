//
//  ViewModel.swift
//  SCMovies
//
//  Created by Aung Phyoe on 7/12/21.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    func onSuccess()
    func onFailure(error: Error?)
    func isLoading(loading: Bool)
}

class BaseViewModel: NSObject {
    //MARK: Properties
    weak var delegate: ViewModelDelegate?
    init(_ delegate: ViewModelDelegate? = nil) {
        super.init()
        self.delegate = delegate
    }
    
    var loading: Bool = false {
        didSet {
            if loading != oldValue {
                if self.delegate?.isLoading != nil {
                    self.delegate?.isLoading(loading: loading)
                }
            }
        }
    }
    
    func success() {
        self.delegate?.onSuccess()
    }
    
    func failure(error: Error?) {
        self.delegate?.onFailure(error: error)
    }
}
