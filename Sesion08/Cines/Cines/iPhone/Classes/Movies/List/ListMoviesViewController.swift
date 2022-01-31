//
//  ListMoviesViewController.swift
//  Cines
//
//  Created by Kenyi Rodriguez on 31/01/22.
//

import UIKit

class ListMoviesViewController: UIViewController {
        
    @IBOutlet private weak var tlvMovies: UITableView!
    
    private let webService = MovieWS()
    private var arrayMovies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tlvMovies.dataSource = self
        self.tlvMovies.delegate = self
        self.getAllMovies()
    }
    
    func getAllMovies() {
        self.webService.getAllMovies { arrayMoviesDTO in
            self.arrayMovies = arrayMoviesDTO.toMovies
            self.tlvMovies.reloadData()
        }
    }
}

extension ListMoviesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        MovieTableViewCell.buildIn(tableView, indexPath: indexPath, movie: self.arrayMovies[indexPath.row])
    }
}

extension ListMoviesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let movie = self.arrayMovies[indexPath.row]
        print("Se selecionó la película " + movie.title)
    }
}
