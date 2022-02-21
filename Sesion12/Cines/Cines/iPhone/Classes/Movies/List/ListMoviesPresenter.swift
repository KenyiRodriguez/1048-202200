//
//  ListMoviesPresenter.swift
//  Cines
//
//  Created by Kenyi Rodriguez on 21/02/22.
//

import Foundation

struct ListMoviesPresenter {
    
    private unowned let controller: ListMoviesViewControllerProtocol
    private let webService = MovieWS()
    
    init(controller: ListMoviesViewControllerProtocol) {
        self.controller = controller
    }
}

extension ListMoviesPresenter {
    
    func didLoad() {
        
        self.controller.configureView()
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

extension ListMoviesPresenter {
    
    private func getAllMovies() {
        
        self.controller.showLoading(true)
        
        self.webService.getAllMovies { arrayMoviesDTO in
            self.controller.showLoading(false)
            let arrayMovies = arrayMoviesDTO.toMovies
            self.controller.reloadSearchData(arrayMovies)
            self.controller.reloadListData(arrayMovies)
        }
    }
}
