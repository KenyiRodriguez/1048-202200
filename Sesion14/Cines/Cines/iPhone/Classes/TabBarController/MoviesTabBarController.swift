//
//  MoviesTabBarController.swift
//  Cines
//
//  Created by Kenyi Rodriguez on 28/02/22.
//

import UIKit

class MoviesTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [ListMoviesViewController.buildOnline(), ListMoviesViewController.buildLocal()]
    }
}

extension MoviesTabBarController {
    
    class func build() -> MoviesTabBarController {
        
        let storyboard = UIStoryboard(name: "Movies", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "MoviesTabBarController") as? MoviesTabBarController else {
            return MoviesTabBarController()
        }
        
        return controller
    }
}
