//
//  ViewController.swift
//  CicloDeVida
//
//  Created by Kenyi Rodriguez on 4/02/22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("LoginViewController - viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("LoginViewController - viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("LoginViewController - viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("LoginViewController - viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("LoginViewController - viewDidDisappear")
    }
    
    
    
    
    
    
    
    
    
    
    func login(usuer: String, password: String) {
        
    }
    
    @IBAction func tapToCLose() {
        
    }
    
    func meCai() {
        self.llorar()
        self.llamarAMama()
    }
    
    func llamarAMama() {
        
    }
    
    func llorar() {
        print("Estoy llorando")
    }
}
