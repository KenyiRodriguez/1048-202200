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
    func setTitleHeader()
}

class ListMoviesViewController: UIViewController {
    
    @IBOutlet private weak var clvMovies: UICollectionView!
    @IBOutlet private weak var srcMovies: UISearchBar!
    @IBOutlet private weak var lblTitle: UILabel!
    
    var searchAdapter: SearchMovieAdapter!
    var listAdapter: ListMovieAdapter!
    var presenter: ListMoviesPresenterProtocol!
    
    lazy private var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.pullToRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
}

extension ListMoviesViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.didLoad?()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.willAppear?()
    }
    
    @IBAction private func pullToRefresh(_ sender: Any) {
        self.presenter.pullToRefresh?()
    }
}

extension ListMoviesViewController: ListMoviesViewControllerProtocol {
    
    func setTitleHeader() {
        self.lblTitle.text = self.title
    }
    
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
    
    class func buildOnline() -> ListMoviesViewController {
        
        let storyboard = UIStoryboard(name: "Movies", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "ListMoviesViewController") as? ListMoviesViewController else {
            return ListMoviesViewController()
        }
        
        controller.searchAdapter = SearchMovieAdapter(controller: controller)
        controller.listAdapter = ListMovieAdapter(controller: controller)
        controller.presenter = ListOnlineMoviesPresenter(controller: controller)
        controller.title = "CINEMA PRO!"
        controller.tabBarItem.title = "Cartelera"
        controller.tabBarItem.image = UIImage(systemName: "rectangle.3.group")
        controller.tabBarItem.selectedImage = UIImage(systemName: "rectangle.3.group.fill")
        return controller
    }
    
    class func buildLocal() -> ListMoviesViewController {
        
        let storyboard = UIStoryboard(name: "Movies", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "ListMoviesViewController") as? ListMoviesViewController else {
            return ListMoviesViewController()
        }
        
        controller.searchAdapter = SearchMovieAdapter(controller: controller)
        controller.listAdapter = ListMovieAdapter(controller: controller)
        controller.presenter = ListLocalMoviesPresenter(controller: controller)
        controller.title = "MIS FAVORITOS"
        controller.tabBarItem.title = "Favoritos"
        controller.tabBarItem.image = UIImage(systemName: "star")
        controller.tabBarItem.selectedImage = UIImage(systemName: "star.fill")
        
        return controller
    }
}
