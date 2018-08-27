//
//  ViewController.swift
//  FirebaseCrud
//
//  Created by Ricardo Moreno on 8/26/18.
//  Copyright © 2018 blackricks. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var control: UISegmentedControl!
    @IBOutlet weak var correo: UITextField!
    @IBOutlet weak var contrasena: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticLogin()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func login(_ sender: UIButton) {
        if control.selectedSegmentIndex == 0 {
            login(correo: correo.text!, password: contrasena.text!)
        } else {
            register(correo: correo.text!, password: contrasena.text!)
        }
    }
    
    func login(correo: String, password: String) {
        Auth.auth().signIn(withEmail: correo, password: password) { (user, error) in
            if let _ = user {
                self.performSegue(withIdentifier: "inicio", sender: self)
            } else {
                if let error = error?.localizedDescription {
                    print("Error Firebase inicio de sesión", error)
                } else {
                    print("Hubo otro error")
                }
            }
        }
    }
    
    func register(correo: String, password: String) {
        Auth.auth().createUser(withEmail: correo, password: password) { (user, error) in
            if let _ = user {
                self.performSegue(withIdentifier: "inicio", sender: self)
            } else {
                if let error = error?.localizedDescription {
                    print("Error Firebase registro", error)
                } else {
                    print("Hubo otro error")
                }
            }
        }
    }
    
    func automaticLogin() {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            guard let _ = user else { print("no estamos logueados"); return }
            self.performSegue(withIdentifier: "inicio", sender: self)
        }
    }
    
}

