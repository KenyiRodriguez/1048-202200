//
//  LoginViewController.swift
//  Cines
//
//  Created by Kenyi Rodriguez on 24/01/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet private weak var txtUser: UITextField!
    @IBOutlet private weak var txtPassword: UITextField!
    @IBOutlet private weak var viewContent: UIView!
    @IBOutlet private weak var anchorCenterContentY: NSLayoutConstraint!
    
    //OJO: ESTE SE EJECUTA UNA SOLA VEZ!!!!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //TODOS ESTOS SE EJECURA VARIAS VECES
    //Estado de actividad
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.registrarKeyboardNotifications()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //Estado de reposo
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.unregisterKeyboardNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    @IBAction private func tapToCloseKeyboard(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction private func swipeToCloseKeyboard(_ sender: UISwipeGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction private func swipeToOpenKeyboard(_ sender: UISwipeGestureRecognizer) {
        if self.txtUser.text?.count == 0 {
            self.txtUser.becomeFirstResponder()
        } else {
            self.txtPassword.becomeFirstResponder()
        }
    }
    
    @IBAction private func clickBtnLogin(_ sender: UIButton) {
        
        guard let user = self.txtUser.text, user.count > 0 else {
            self.showAutomaticAlertWithTitle("UPS OCURRIO UN PROBLEMA", message: "El usuario ingresado es inválido. Ingrese un nuevo usuario")
            return
        }
        
        guard let password = self.txtPassword.text, password.count > 0 else {
            self.showAutomaticAlertWithTitle("UPS OCURRIO UN PROBLEMA", message: "El password ingresado es inválido. Ingrese un nuevo password")
            return
        }
        
        print("HOLA: \(user):\(password)")
    }
}

//MARK: - Keyboard Manager
extension LoginViewController {
    
    private func registrarKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func unregisterKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        
        let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero
        
        if keyboardFrame.origin.y < self.viewContent.frame.maxY {
            
            UIView.animate(withDuration: animationDuration, delay: 0, options: [.curveEaseInOut], animations: {
                self.anchorCenterContentY.constant = keyboardFrame.origin.y - self.viewContent.frame.maxY
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        
        let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
        
        UIView.animate(withDuration: animationDuration) {
            self.anchorCenterContentY.constant = 0
            self.view.layoutIfNeeded()
        }
    }
}

