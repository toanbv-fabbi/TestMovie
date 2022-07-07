//
//  SeachViewModel.swift
//  Test
//
//  Created by cmc on 07/07/2022.
//

import UIKit

protocol SeachMovieDelegate: AnyObject {
    func updateData()
    func showLoading()
    func hideLoading()
    func showError()
}

class SeachMovieViewModel {
    let searchService: SeachService
    weak var delegate: SeachMovieDelegate?
    var page = Constants.pageDefault
    var searchResults = [MovieData]()
    var currentKeyword = ""
    var isLoading = false
    
    init(searchService: SeachService = SeachRepository()) {
        self.searchService = searchService
    }
    
    func search(keyword: String) {
        isLoading = false
        if keyword.isEmpty {
            page = Constants.pageDefault
            searchResults.removeAll()
            self.delegate?.updateData()
        } else {
            delegate?.showLoading()
            isLoading = true
            searchService.search(keyword: keyword, page: page) { [weak self] result in
                guard let self = self else { return }
                self.delegate?.hideLoading()
                self.isLoading = false
                switch result {
                case .failure(let error):
                    self.delegate?.showError()
                case .success(let result):
                    if let data = result.data, !data.isEmpty {
                        self.page += 1
                        self.searchResults += data
                        self.delegate?.updateData()
                    }
                }
            }
        }
        currentKeyword = keyword
    }
    
    func loadMore() {
        search(keyword: currentKeyword)
    }
}
