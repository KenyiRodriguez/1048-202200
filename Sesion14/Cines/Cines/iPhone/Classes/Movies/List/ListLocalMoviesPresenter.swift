//
//  ListLocalMoviesPresenter.swift
//  Cines
//
//  Created by Kenyi Rodriguez on 28/02/22.
//

import Foundation

class ListLocalMoviesPresenter: NSObject {
    
    private unowned let controller: ListMoviesViewControllerProtocol
    private let dataBase = MovieDA()
    
    init(controller: ListMoviesViewControllerProtocol) {
        self.controller = controller
    }
}

extension ListLocalMoviesPresenter: ListMoviesPresenterProtocol {
    
    func didLoad() {
        self.controller.setupAdapters()
        self.controller.setTitleHeader()
    }
    
    func willAppear() {
        self.getAllMovies()
    }
}

extension ListLocalMoviesPresenter {
    
    private func getAllMovies() {
        
        let result = self.dataBase.listAllSorted()
        let arrayMovies: [Any] = result.count == 0 ? ["Aún no tienes favoritos agregados."] : result.toMovies
        
        self.controller.reloadSearchData(arrayMovies as? [Movie] ?? [])
        self.controller.reloadListData(arrayMovies)
    }
}
