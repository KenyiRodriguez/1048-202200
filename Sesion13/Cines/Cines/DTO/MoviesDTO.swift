//
//  MoviesDTO.swift
//  Cines
//
//  Created by Kenyi Rodriguez on 28/01/22.
//

import Foundation

struct PageMoviesDTO: Decodable {
    let page: Int?
    let total_pages: Int?
    let total_results: Int?
    let results: [MovieDTO]
}

struct MovieDTO: Decodable {
    let id: Int?
    let overview: String?
    let poster_path: String?
    let release_date: String?
    let title: String?
    let vote_average: Double?
}
