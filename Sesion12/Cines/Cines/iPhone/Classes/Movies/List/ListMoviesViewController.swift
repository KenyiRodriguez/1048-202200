//
//  ListMoviesViewController.swift
//  Cines
//
//  Created by Kenyi Rodriguez on 31/01/22.
//

import UIKit

protocol ListMoviesViewControllerProtocol: NSObjectProtocol {
    func didFilterWithResult(_ arrayResult: [Any])
    func goToMovieDetail(_ movie: Movie)
    func showLoading(_ show: Bool)
    func reloadListData(_ arrayData: [Any])
    func reloadSearchData(_ arrayData: [Movie])
    func setupAdapters()
    func configureView()
    func didEdit()
}

class ListMoviesViewController: UIViewController {
    
    @IBOutlet private weak var clvMovies: UICollectionView!
    @IBOutlet private weak var srcMovies: UISearchBar!
    
    lazy private var searchAdapter = SearchMovieAdapter(controller: self)
    lazy private var listAdapter = ListMovieAdapter(controller: self)
    lazy private var presenter = ListMoviesPresenter(controller: self)
    
    lazy private var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.pullToRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let controller = segue.destination as? MovieDetailViewController, let movie = sender as? Movie {
            controller.movie = movie
        }
    }
}

extension ListMoviesViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.didLoad()
    }
    
    @IBAction private func pullToRefresh(_ sender: Any) {
        self.presenter.pullToRefresh()
    }
}

extension ListMoviesViewController: ListMoviesViewControllerProtocol {
    
    func didEdit() {
        self.srcMovies.text = ""
        self.view.endEditing(true)
    }
    
    func configureView() {
        self.clvMovies.addSubview(self.refreshControl)
    }
    
    func setupAdapters() {
        self.searchAdapter.setSearchBar(self.srcMovies)
        self.listAdapter.setCollectionView(self.clvMovies)
    }
    
    func reloadSearchData(_ arrayData: [Movie]) {
        self.searchAdapter.dataSource = arrayData
    }
    
    func reloadListData(_ arrayData: [Any]) {
        self.listAdapter.dataSource = arrayData
        self.clvMovies.reloadData()
    }
    
    func showLoading(_ show: Bool) {
        show ? self.refreshControl.beginRefreshing() : self.refreshControl.endRefreshing()
    }
    
    func goToMovieDetail(_ movie: Movie) {
        self.performSegue(withIdentifier: "MovieDetailViewController", sender: movie)
    }
    
    func didFilterWithResult(_ arrayResult: [Any]) {
        self.listAdapter.dataSource = arrayResult
        self.clvMovies.reloadData()
    }
}
