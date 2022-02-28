//
//  ListMoviesPresenter.swift
//  Cines
//
//  Created by Kenyi Rodriguez on 21/02/22.
//

import Foundation

class ListOnlineMoviesPresenter: NSObject {
    
    private unowned let controller: ListMoviesViewControllerProtocol
    private let webService = MovieWS()
    
    init(controller: ListMoviesViewControllerProtocol) {
        self.controller = controller
    }
}

extension ListOnlineMoviesPresenter: ListMoviesPresenterProtocol {
    
    func didLoad() {
    
        self.controller.configureView()
        self.controller.setTitleHeader()
        self.controller.setupAdapters()
        self.controller.showLoading(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.getAllMovies()
        }
    }
    
    func pullToRefresh() {
        self.controller.didEdit()
        self.getAllMovies()
    }
}

extension ListOnlineMoviesPresenter {
    
    private func getAllMovies() {
        
        self.controller.showLoading(true)
        
        self.webService.getAllMovies { arrayMoviesDTO in
            
            self.controller.showLoading(false)
            let arrayMovies = arrayMoviesDTO.toMovies
            self.controller.reloadSearchData(arrayMovies)
            self.controller.reloadListData(arrayMovies)
            
        } errorHandler: { errorMessage in
            
            self.controller.showLoading(false)
            self.controller.reloadSearchData([])
            self.controller.reloadListData([errorMessage])
        }
    }
}
