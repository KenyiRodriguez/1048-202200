//
//  MovieDetailViewController.swift
//  Cines
//
//  Created by Kenyi Rodriguez on 31/01/22.
//

import UIKit
import Alamofire

class MovieDetailViewController: UIViewController {
    
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblReleaseDate: UILabel!
    @IBOutlet private weak var lblOverview: UILabel!
    @IBOutlet private weak var imgMovie: UIImageView!
    @IBOutlet private weak var imgMovieBackground: UIImageView!
    @IBOutlet var arrayStars: [UIImageView]!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateData()
    }
    
    func updateData() {
        
        guard let movie = self.movie else { return }
        
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
