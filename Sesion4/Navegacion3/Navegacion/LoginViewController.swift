//
//  LoginViewController.swift
//  Navegacion
//
//  Created by Kenyi Rodriguez on 14/01/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet private weak var txtUser: UITextField!
    @IBOutlet private weak var txtPassword: UITextField!
    
    @IBAction private func clickBtnLogin(_ sender: UIButton) {
        
        guard let user = self.txtUser.text, user.count > 0 else {
            self.showAutomaticAlertWithTitle("Error", message: "Ingrese un usuario válido")
            return
        }
        
        guard let password = self.txtPassword.text, password.count > 0 else {
            self.showAutomaticAlertWithTitle("Error", message: "Ingrese un password válido")
            return
        }
 
        print("Estas son las credenciales para enviar al servicio: \(user):\(password)")
        self.performSegue(withIdentifier: "HomeViewController", sender: nil)
    }
}
