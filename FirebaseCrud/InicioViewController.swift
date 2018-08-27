//
//  InicioViewController.swift
//  FirebaseCrud
//
//  Created by Ricardo Moreno on 8/26/18.
//  Copyright © 2018 blackricks. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class InicioViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var nombreJuego: UITextField!
    @IBOutlet weak var generoJuego: UITextField!
    @IBOutlet weak var generoLabel: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    var plataforma: String?
    var plataformas = ["PS4", "Xbox One", "Nintendo", "PC"]
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
        if let correo = Auth.auth().currentUser?.email {
            print("El correo del usuario es : \(correo)")
        }
        ref = Database.database().reference()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return plataformas[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return plataformas.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        plataforma = plataformas[row]
        generoLabel.text = plataforma
    }

    @IBAction func saveGame(_ sender: UIButton) {
        //se genera un id
        let id = ref.childByAutoId().key
        let campos = ["nombre": nombreJuego.text!,
                      "genero": generoJuego.text!,
                      "id": id]
        if let plataforma = plataforma {
            ref.child(plataforma).child(id).setValue(campos)
            print("guardo")
            limpiar()
        }
    }
    
    @IBAction func logout(_ sender: UIButton) {
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "login", sender: self)
    }
    
    func limpiar() {
        nombreJuego.text = ""
        generoJuego.text = ""
    }
}
