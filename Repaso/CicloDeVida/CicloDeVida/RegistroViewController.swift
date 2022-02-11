//
//  RegistroViewController.swift
//  CicloDeVida
//
//  Created by Kenyi Rodriguez on 4/02/22.
//

import UIKit

class RegistroViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("RegistroViewController - viewDidLoad")
        
        self.sumar(n1: 10, n2: 19) { sumatoria in
            print(sumatoria)
        }
        
        print("Hola 1")
        print("Hola 2")
        print("Hola 3")
        print("Hola 4")
        print("Hola")
        print("Hola")
        print("Hola")
        print("Hola")
        print("Hola")
        print("Hola")
        print("Hola")
        print("Hola")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("RegistroViewController - viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("RegistroViewController - viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("RegistroViewController - viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("RegistroViewController - viewDidDisappear")
    }
        
    func sumar(n1: Int, n2: Int, sumaCompletion: @escaping SumaCompletionHandler) {
        let suma = n1 + n2
        sumaCompletion(suma)
    }
    
}

typealias SumaCompletionHandler = (_ sumatoria: Int) -> Void
