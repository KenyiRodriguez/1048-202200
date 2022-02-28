//
//  Movie.swift
//  Cines
//
//  Created by Kenyi Rodriguez on 31/01/22.
//

import Foundation
import UIKit

struct Movie {
    
    let id: Int
    let overview: String
    let posterPath: String
    let releaseDate: Date?
    let title: String
    let voteAverage: Int
    
    var urlImage: String {
        "https://image.tmdb.org/t/p/w500" + self.posterPath
    }
    
    var releaseFormat: String {
        
        guard let date = self.releaseDate else { return "Próximamente" }
        
        let dateFormartter = DateFormatter()
        dateFormartter.dateFormat = "dd MMM yyyy"
        dateFormartter.locale = Locale(identifier: "es_pe")
        return dateFormartter.string(from: date)
    }
    
    init(_ dto: MovieDTO) {
        
        self.id = dto.id ?? 0
        self.overview = dto.overview ?? "Descripción no disponible"
        self.posterPath = dto.poster_path ?? ""
        self.title = dto.title ?? "Sin nombre"
        self.voteAverage = Int(dto.vote_average ?? 0)
        
        let dateFormartter = DateFormatter()
        dateFormartter.dateFormat = "yyyy-MM-dd"
        self.releaseDate = dateFormartter.date(from: dto.release_date ?? "")
    }
    
    init(_ dto: MovieDB) {
        
        self.id = Int(dto.id)
        self.overview = dto.overview ?? "Descripción no disponible"
        self.posterPath = dto.posterPath ?? ""
        self.title = dto.title ?? "Sin nombre"
        self.voteAverage = Int(dto.voteAverage)
        self.releaseDate = dto.releaseDate
    }
}

extension MovieDB {
    var toMovie: Movie { Movie(self) }
}

extension Array where Element == MovieDB {
    var toMovies: [Movie] {
        self.map({ $0.toMovie })
    }
}

extension MovieDTO {
    var toMovie: Movie { Movie(self) }
}

extension Array where Element == MovieDTO {
    var toMovies: [Movie] {
        self.map({ $0.toMovie })
    }
}
