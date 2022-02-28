//
//  MovieDA.swift
//  Cines
//
//  Created by Kenyi Rodriguez on 28/02/22.
//

import Foundation
import CoreData

struct MovieDA {
    
    let manager = DataBaseManager.current
    
    @discardableResult func add(_ movie: Movie) -> MovieDB? {
        
        guard let objDM = NSEntityDescription.insertNewObject(forEntityName: "MovieDB", into: self.manager.context) as? MovieDB else {
            return nil
        }
        
        objDM.id = Int64(movie.id)
        objDM.title = movie.title
        objDM.overview = movie.overview
        objDM.posterPath = movie.posterPath
        objDM.releaseDate = movie.releaseDate
        objDM.voteAverage = Int16(movie.voteAverage)
            
        return objDM
    }
    
    func listAll() -> [MovieDB] {
        
        let fetchRequest: NSFetchRequest<MovieDB> = MovieDB.fetchRequest()
        let result = try? self.manager.context.fetch(fetchRequest)
        return result ?? []
    }
    
    func listAllSorted() -> [MovieDB] {
        
        let fetchRequest: NSFetchRequest<MovieDB> = MovieDB.fetchRequest()
        
        let sortReleaseDate = NSSortDescriptor(key: "releaseDate", ascending: false)
        fetchRequest.sortDescriptors = [sortReleaseDate]
        
        let result = try? self.manager.context.fetch(fetchRequest)
        return result ?? []
    }
    
    func getMovieById(_ id: Int) -> MovieDB? {
        
        let movies = self.listAll()
        let movie = movies.first(where: { $0.id == Int64(id) })
        return movie
    }
    
    func deleteById(_ id: Int) {
        guard let movie = self.getMovieById(id) else { return }
        self.manager.context.delete(movie)
    }
}
