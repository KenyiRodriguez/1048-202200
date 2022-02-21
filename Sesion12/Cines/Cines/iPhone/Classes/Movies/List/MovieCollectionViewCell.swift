//
//  MovieTableViewCell.swift
//  Cines
//
//  Created by Kenyi Rodriguez on 31/01/22.
//

import UIKit
import Alamofire

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblReleaseDate: UILabel!
    @IBOutlet private weak var imgMovie: UIImageView!
    @IBOutlet private weak var anchorImageWidth: NSLayoutConstraint!
    
    private func updateData(_ movie: Movie) {
        
        self.animateAppear()
        
        self.lblTitle.text = movie.title
        self.lblReleaseDate.text = movie.releaseFormat
 
        let request = AF.request(movie.urlImage)
        request.response { dataResponse in
            guard let data = dataResponse.data else { return }
            self.imgMovie.image = UIImage(data: data)
        }
    }
    
    func updateWidth(_ width: CGFloat) {
        self.anchorImageWidth.constant = width
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.imgMovie.layer.cornerRadius = 10
    }
    
    private func animateAppear() {
        
        self.alpha = 0
        self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        let randomDelay = CGFloat.random(in: 0...(0.5))
        
        UIView.animate(withDuration: 0.5, delay: randomDelay, options: .curveEaseInOut, animations: {
            self.alpha = 1
            self.transform = .identity
        }, completion: nil)
    }
}

extension MovieCollectionViewCell {

    class func buildIn(_ collectionView: UICollectionView, indexPath: IndexPath, movie: Movie) -> MovieCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell
        cell?.updateData(movie)
        return cell ?? MovieCollectionViewCell()
    }
}
