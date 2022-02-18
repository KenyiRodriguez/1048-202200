//
//  ForgotPasswordViewController.swift
//  Cines
//
//  Created by Kenyi Rodriguez on 24/01/22.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction private func clickBtnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
