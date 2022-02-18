//
//  ListMoviesViewController.swift
//  Cines
//
//  Created by Kenyi Rodriguez on 31/01/22.
//

import UIKit

class ListMoviesViewController: UIViewController {
        
    @IBOutlet private weak var clvMovies: UICollectionView!
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
        
        self.clvMovies.addSubview(self.refreshControl)
        self.srcMovies.delegate = self
        self.clvMovies.dataSource = self
        self.clvMovies.delegate = self
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
            self.clvMovies.reloadData()
        }
    }
    
//    func deleteMovie(_ movie: Movie, atIndexPath indexPath: IndexPath) {
//
//        self.arrayDataToShow.remove(at: indexPath.row)
//        self.arrayMovies.removeAll(where: { $0.id == movie.id })
//        self.tlvMovies.deleteRows(at: [indexPath], with: .automatic)
//    }
    
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
        self.clvMovies.reloadData()
    }
}

extension ListMoviesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayDataToShow.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let movie = self.arrayDataToShow[indexPath.row] as? Movie {
            return MovieCollectionViewCell.buildIn(collectionView, indexPath: indexPath, movie: movie)
            
        } else if let errorMessage = self.arrayDataToShow[indexPath.row] as? String {
            return ErrorCollectionViewCell.buildIn(collectionView, indexPath: indexPath, errorMessage: errorMessage)
            
        } else {
            return UICollectionViewCell()
        }
    }
}

extension ListMoviesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let movie = self.arrayDataToShow[indexPath.row] as? Movie {
            self.performSegue(withIdentifier: "MovieDetailViewController", sender: movie)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        if let cell = cell as? MovieCollectionViewCell {
            
            let numberOfColumns: CGFloat = 3
            let totalWidth = collectionView.frame.width
            let insets = flowLayout.sectionInset.left + flowLayout.sectionInset.right
            let minSpaces = flowLayout.minimumInteritemSpacing * (numberOfColumns - 1)
            
            let availableWidth = totalWidth - insets - minSpaces
            let cellWidth = availableWidth / numberOfColumns
            
            cell.updateWidth(cellWidth.rounded(.down))
            
        } else if let cell = cell as? ErrorCollectionViewCell {
            
            var collectionSize = collectionView.frame.size
            collectionSize.width -= (flowLayout.sectionInset.left + flowLayout.sectionInset.right)
            collectionSize.height -= (flowLayout.sectionInset.top + flowLayout.sectionInset.bottom)
            
            cell.updateSize(collectionSize)
        }
    }
}
