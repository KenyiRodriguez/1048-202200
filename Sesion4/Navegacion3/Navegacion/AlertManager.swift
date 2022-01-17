//
//  AlertManager.swift
//  Navegacion
//
//  Created by Kenyi Rodriguez on 17/01/22.
//

import UIKit

extension UIViewController {
    
    func showAlertWithTitle(_ title: String, message: String, acceptTitle: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let acceptAction = UIAlertAction(title: acceptTitle, style: .cancel, handler: nil)
        alertController.addAction(acceptAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAutomaticAlertWithTitle(_ title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        self.present(alertController, animated: true) {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                alertController.dismiss(animated: true, completion: nil)
            }
        }
    }
}
