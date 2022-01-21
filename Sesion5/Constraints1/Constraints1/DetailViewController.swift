//
//  DetailViewController.swift
//  Constraints1
//
//  Created by Kenyi Rodriguez on 21/01/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var lblMessage: UILabel!
    
    @IBAction func clickBtnSeeMore(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.4) {
            let isColapse = self.lblMessage.numberOfLines == 0
            self.lblMessage.numberOfLines = isColapse ? 2 : 0
            sender.configuration?.title = isColapse ? "Ver más" : "Ver menos"
            self.view.layoutIfNeeded()
        }
    }
}
