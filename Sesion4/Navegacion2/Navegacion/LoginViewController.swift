//
//  LoginViewController.swift
//  Navegacion
//
//  Created by Kenyi Rodriguez on 14/01/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var lblHello: UILabel!
    
    @IBAction func clickBtnHello(_ sender: Any) {
        self.lblHello.text = "Hola, Soy Kenyi!! ¿Quieres jalar iOS?"
    }
}
