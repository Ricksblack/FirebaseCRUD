//
//  VistaViewController.swift
//  FirebaseCrud
//
//  Created by Ricardo Moreno on 8/26/18.
//  Copyright © 2018 blackricks. All rights reserved.
//

import UIKit
import FirebaseDatabase

class VistaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tabla: UITableView!
    var listaJuegos = [Juegos]()
    var ref: DatabaseReference!
    var handle: DatabaseHandle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabla.delegate = self
        tabla.dataSource = self
        
        ref = Database.database().reference()
        handle = ref.child("PS4").observe(DataEventType.value, with: { (snapshot) in
            self.listaJuegos.removeAll()
            for item in snapshot.children.allObjects as! [DataSnapshot] {
                let valores = item.value as? [String: AnyObject]
                let nombre = valores!["nombre"] as? String
                let genero = valores!["genero"] as? String
                
                let juego = Juegos(nombre: nombre, genero: genero)
                self.listaJuegos.append(juego)
            }
            self.tabla.reloadData()
        })
    }

    @IBAction func atras(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaJuegos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabla.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let juego = listaJuegos[indexPath.row]
        cell.textLabel?.text = juego.nombre
        cell.detailTextLabel?.text = juego.genero
        
        return cell
    }
}
