//
//  SecondDetailViewController.swift
//  Constraints1
//
//  Created by Kenyi Rodriguez on 21/01/22.
//

import UIKit

class SecondDetailViewController: UIViewController {
    
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var anchoHeightViewContent: NSLayoutConstraint!
    
    @IBAction func clickBtnSeeMore(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.4) {
            
            let random = CGFloat.random(in: 150...400)
            self.anchoHeightViewContent.constant = random
            self.view.layoutIfNeeded()
        }
    }
}
