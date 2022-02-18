//
//  MovieWS.swift
//  Cines
//
//  Created by Kenyi Rodriguez on 28/01/22.
//

import Foundation
import Alamofire

struct MovieWS {
    
    func getAllMovies(puntoEscape: @escaping (_ arrayMoviesDTO: [MovieDTO]) -> Void) {
        
        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=176de15e8c8523a92ff640f432966c9c"
        let request = AF.request(urlString, method: .get)
        request.response { dataResponse in
            
            guard let data = dataResponse.data else {
                print("Error de conexión")
                puntoEscape([])
                return
            }
            
            let jsonDecoder = JSONDecoder()
            let pageMovie = try? jsonDecoder.decode(PageMoviesDTO.self, from: data)
            puntoEscape(pageMovie?.results ?? [])
        }
    }
}
