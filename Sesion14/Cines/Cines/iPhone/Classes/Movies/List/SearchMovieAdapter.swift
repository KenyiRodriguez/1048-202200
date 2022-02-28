//
//  SearchMovieAdapter.swift
//  Cines
//
//  Created by Kenyi Rodriguez on 21/02/22.
//

import UIKit

class SearchMovieAdapter: NSObject {
    
    private unowned let controller: ListMoviesViewControllerProtocol
    var dataSource = [Movie]()
    
    init(controller: ListMoviesViewControllerProtocol) {
        self.controller = controller
    }
    
    func setSearchBar(_ searchBar: UISearchBar) {
        searchBar.delegate = self
    }
}

extension SearchMovieAdapter: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let arrayData: [Any]
        
        if searchText.count == 0 {
            arrayData = self.dataSource
            
        } else {
            
            arrayData = self.dataSource.filter({ movie in
                let textFilter = searchText.lowercased()
                let titleFilter = movie.title.lowercased()
                
                return titleFilter.contains(textFilter)
            })
        }
        let arrayResult = arrayData.count == 0 ? ["No se encontró resultados para la búsquedade:\n\n\(searchText)"] : arrayData
        
        self.controller.didFilterWithResult(arrayResult)
    }
}
