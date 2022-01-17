//
//  ConfigurationViewController.swift
//  Navegacion
//
//  Created by Kenyi Rodriguez on 17/01/22.
//

import UIKit

class ConfigurationViewController: UIViewController {
    
    @IBAction private func clickBtnCloseSession(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Cerrar sesión", message: "¿Está seguro que desea cerrar sesión?", preferredStyle: .alert)
        
        let acceptAction = UIAlertAction(title: "Si", style: .default) { _ in
            self.navigationController?.popToRootViewController(animated: true)
        }
        alertController.addAction(acceptAction)
        
        let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
