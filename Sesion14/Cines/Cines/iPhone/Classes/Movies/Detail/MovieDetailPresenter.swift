//
//  MovieDetailPresenter.swift
//  Cines
//
//  Created by Kenyi Rodriguez on 21/02/22.
//

import Foundation

class MovieDetailPresenter {
    
    private unowned let controller: MovieDetailViewControllerProtocol
    private let webService = MovieWS()
    private let dataBase = MovieDA()
    private var movie: Movie?
    
    init(controller: MovieDetailViewControllerProtocol) {
        self.controller = controller
    }
    
    func didLoad() {
        self.controller.showLoading(true)
    }
    
    func didAppear() {
        self.getDetail()
    }
    
    func addToFavorite() {
        
        guard let movie = self.movie else { return }
        
        if self.dataBase.getMovieById(movie.id) == nil {
            self.dataBase.add(movie)
            self.controller.setFavoriteStyle(true)
            
        } else {
            
            self.dataBase.deleteById(movie.id)
            self.controller.setFavoriteStyle(false)
        }
        
        DataBaseManager.current.saveContext()
    }
    
    func getDetail() {
        
        self.webService.getDetail(self.controller.idMovie) { movieDTO in
            
            let isFavorite = self.dataBase.getMovieById(self.controller.idMovie) != nil
            self.controller.setFavoriteStyle(isFavorite)
            self.controller.animateShowLoading(false)
            
            let movie = movieDTO.toMovie
            self.movie = movie
            self.controller.updateData(movie)
            
        } errorHandler: { errorMessage in
            
            self.controller.animateShowLoading(false)
            print(errorMessage)
        }
    }
}
