//
//  MainNavigationController.swift
//  Cines
//
//  Created by Kenyi Rodriguez on 25/02/22.
//

import UIKit

class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [ListMoviesViewController.build()]
    }
}
