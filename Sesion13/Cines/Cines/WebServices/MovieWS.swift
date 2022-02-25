//
//  MovieWS.swift
//  Cines
//
//  Created by Kenyi Rodriguez on 28/01/22.
//

import Foundation
import Alamofire

typealias MoviesHandler = (_ arrayMoviesDTO: [MovieDTO]) -> Void
typealias MovieHandler = (_ movieDTO: MovieDTO) -> Void
typealias ErrorHandler = (_ errorMessage: String) -> Void


struct MovieWS {
    
    func getAllMovies(successHandler: @escaping MoviesHandler, errorHandler: @escaping ErrorHandler) {
        
        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=176de15e8c8523a92ff640f432966c9c"
        let request = AF.request(urlString, method: .get)
        request.response { dataResponse in
            
            guard let data = dataResponse.data else {
                errorHandler("Error de conexión")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            let pageMovie = try? jsonDecoder.decode(PageMoviesDTO.self, from: data)
            successHandler(pageMovie?.results ?? [])
        }
    }
    
    func getDetail(_ idMovie: Int, successHandler: @escaping MovieHandler, errorHandler: @escaping ErrorHandler) {
        
        let urlString = "https://api.themoviedb.org/3/movie/\(idMovie)?api_key=752cd23fdb3336557bf3d8724e115570"
        let request = AF.request(urlString, method: .get)
        request.response { dataResponse in
            
            guard let data = dataResponse.data else {
                errorHandler("Error de conexión")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            guard let movieDTO = try? jsonDecoder.decode(MovieDTO.self, from: data) else {
                errorHandler("La película no se encuentra disponible")
                return
            }
            
            successHandler(movieDTO)
        }
    }
}
