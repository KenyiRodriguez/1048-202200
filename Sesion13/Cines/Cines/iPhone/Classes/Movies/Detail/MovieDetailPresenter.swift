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
    
    var temporal = true
    
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
        self.temporal = !self.temporal
        self.controller.setFavoriteStyle(self.temporal)
    }
    
    func getDetail() {
        
        self.webService.getDetail(self.controller.idMovie) { movieDTO in
            
            self.controller.animateShowLoading(false)
            self.controller.updateData(movieDTO.toMovie)
            self.controller.setFavoriteStyle(self.temporal)
            
        } errorHandler: { errorMessage in
            
            self.controller.animateShowLoading(false)
            print(errorMessage)
        }
    }
}
