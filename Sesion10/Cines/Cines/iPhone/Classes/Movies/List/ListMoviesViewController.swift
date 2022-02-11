//
//  ListMoviesViewController.swift
//  Cines
//
//  Created by Kenyi Rodriguez on 31/01/22.
//

import UIKit

class ListMoviesViewController: UIViewController {
        
    @IBOutlet private weak var tlvMovies: UITableView!
    @IBOutlet private weak var srcMovies: UISearchBar!
    
    private let webService = MovieWS()
    private var arrayMovies = [Movie]()
    private var arrayDataToShow = [Any]()
    
    lazy private var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.pullToRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tlvMovies.addSubview(self.refreshControl)
        self.srcMovies.delegate = self
        self.tlvMovies.dataSource = self
        self.tlvMovies.delegate = self
        self.getAllMovies()
    }
    
    @IBAction private func pullToRefresh(_ sender: Any) {
        self.srcMovies.text = ""
        self.view.endEditing(true)
        self.getAllMovies()
    }
    
    func getAllMovies() {
        
        self.refreshControl.beginRefreshing()

        self.webService.getAllMovies { arrayMoviesDTO in
            
            self.refreshControl.endRefreshing()
            self.arrayMovies = arrayMoviesDTO.toMovies
            self.arrayDataToShow = self.arrayMovies
            self.tlvMovies.reloadData()
        }
    }
    
    func deleteMovie(_ movie: Movie, atIndexPath indexPath: IndexPath) {
        
        self.arrayDataToShow.remove(at: indexPath.row)
        self.arrayMovies.removeAll(where: { $0.id == movie.id })
        self.tlvMovies.deleteRows(at: [indexPath], with: .automatic)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let controller = segue.destination as? MovieDetailViewController, let movie = sender as? Movie {
            controller.movie = movie
        }
    }
}

extension ListMoviesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let arrayData: [Any]
        
        if searchText.count == 0 {
            arrayData = self.arrayMovies
            
        } else {
            
            arrayData = self.arrayMovies.filter({ movie in
                let textFilter = searchText.lowercased()
                let titleFilter = movie.title.lowercased()
                
                return titleFilter.contains(textFilter)
            })
        }
        
        self.arrayDataToShow = arrayData.count == 0 ? ["No se encontró resultados para la búsqueda de:\n\n\(searchText)"] : arrayData
        self.tlvMovies.reloadData()
    }
}

extension ListMoviesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayDataToShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let movie = self.arrayDataToShow[indexPath.row] as? Movie {
            return MovieTableViewCell.buildIn(tableView, indexPath: indexPath, movie: movie)
            
        } else if let errorMessage = self.arrayDataToShow[indexPath.row] as? String {
            return ErrorTableViewCell.buildIn(tableView, indexPath: indexPath, errorMessage: errorMessage)
            
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        guard let movie = self.arrayDataToShow[indexPath.row] as? Movie else { return nil }
        
        let goToDetailAction = UIContextualAction(style: .normal, title: "Ver más") { _, _, _ in
            self.performSegue(withIdentifier: "MovieDetailViewController", sender: movie)
        }
        
        goToDetailAction.backgroundColor = .systemIndigo
        goToDetailAction.image = UIImage(systemName: "doc.richtext.fill")
        
        let deleleAction = UIContextualAction(style: .destructive, title: "Eliminar") { _, _, _ in
            //Consumir un servicio de eliminar y cuando este termine, lo eliminas de la tabla
            self.deleteMovie(movie, atIndexPath: indexPath)
        }
        
        deleleAction.image = UIImage(systemName: "trash")
        
        let swipeActions = UISwipeActionsConfiguration(actions: [deleleAction, goToDetailAction])
        return swipeActions
    }
}

extension ListMoviesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let movie = self.arrayDataToShow[indexPath.row] as? Movie {
            self.performSegue(withIdentifier: "MovieDetailViewController", sender: movie)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch self.arrayDataToShow[indexPath.row] {
        case is Movie:
            return UITableView.automaticDimension
        case is String:
            return tableView.frame.height
        default:
            return 0
        }
    }
}
