//
//  MovieDetailViewController.swift
//  Cines
//
//  Created by Kenyi Rodriguez on 31/01/22.
//

import UIKit
import Alamofire

protocol MovieDetailViewControllerProtocol: NSObjectProtocol {
    
    var idMovie: Int! { get set }
    
    func updateData(_ movie: Movie)
    func showLoading(_ show: Bool)
    func animateShowLoading(_ show: Bool)
    func setFavoriteStyle(_ isFavorite: Bool)
}

class MovieDetailViewController: UIViewController {
    
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblReleaseDate: UILabel!
    @IBOutlet private weak var lblOverview: UILabel!
    @IBOutlet private weak var imgMovie: UIImageView!
    @IBOutlet private weak var imgMovieBackground: UIImageView!
    @IBOutlet private weak var loadingView: UIActivityIndicatorView!
    @IBOutlet private weak var scrollContent: UIScrollView!
    @IBOutlet private weak var btnAddToFavorite: UIButton!
    @IBOutlet private var arrayStars: [UIImageView]!
    
    var idMovie: Int!
    var presenter: MovieDetailPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.didLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter.didAppear()
    }
    
    @IBAction private func clickBtnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func clickBtnAddToFavorite(_ sender: Any) {
        self.presenter.addToFavorite()
    }
}

extension MovieDetailViewController: MovieDetailViewControllerProtocol {
    
    func setFavoriteStyle(_ isFavorite: Bool) {
        let imageName = isFavorite ? "star.fill" : "star"
        self.btnAddToFavorite.configuration?.image = UIImage(systemName: imageName)
    }
    
    func showLoading(_ show: Bool) {
        show ? self.loadingView.startAnimating() : self.loadingView.stopAnimating()
        self.scrollContent.alpha = show ? 0 : 1
        self.btnAddToFavorite.alpha = show ? 0 : 1
    }
    
    func animateShowLoading(_ show: Bool) {
        UIView.animate(withDuration: 0.5) {
            self.showLoading(show)
        }
    }
    
    func updateData(_ movie: Movie) {
        
        self.imgMovie.layer.cornerRadius = 10
        self.lblTitle.text = movie.title
        self.lblReleaseDate.text = movie.releaseFormat
        self.lblOverview.text = movie.overview
        
        for (index, imgStar) in self.arrayStars.enumerated() {
            imgStar.image = index < movie.voteAverage ?  UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        }
        
        let request = AF.request(movie.urlImage)
        request.response { dataResponse in
            guard let data = dataResponse.data else { return }
            self.imgMovie.image = UIImage(data: data)
            self.imgMovieBackground.image = self.imgMovie.image
        }
    }
}

extension MovieDetailViewController {
    
    class func build(_ idMovie: Int) -> MovieDetailViewController {
        
        let storyboard = UIStoryboard(name: "Movies", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else {
            return MovieDetailViewController()
        }
        
        controller.idMovie = idMovie
        controller.presenter = MovieDetailPresenter(controller: controller)
        
        return controller
    }
}
