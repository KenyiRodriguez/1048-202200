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
    
    var searchAdapter: SearchMovieAdapter!
    var listAdapter: ListMovieAdapter!
    var presenter: ListMoviesPresenter!
    
    lazy private var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.pullToRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
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
        
        let controller = MovieDetailViewController.build(movie.id)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func didFilterWithResult(_ arrayResult: [Any]) {
        self.listAdapter.dataSource = arrayResult
        self.clvMovies.reloadData()
    }
}

extension ListMoviesViewController {
    
    class func build() -> ListMoviesViewController {
        
        let storyboard = UIStoryboard(name: "Movies", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "ListMoviesViewController") as? ListMoviesViewController else {
            return ListMoviesViewController()
        }
        
        controller.searchAdapter = SearchMovieAdapter(controller: controller)
        controller.listAdapter = ListMovieAdapter(controller: controller)
        controller.presenter = ListMoviesPresenter(controller: controller)
        
        return controller
    }
}
