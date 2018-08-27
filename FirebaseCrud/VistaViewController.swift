//
//  VistaViewController.swift
//  FirebaseCrud
//
//  Created by Ricardo Moreno on 8/26/18.
//  Copyright © 2018 blackricks. All rights reserved.
//

import UIKit

class VistaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tabla: UITableView!
    var listaJuegos = [Juegos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabla.delegate = self
        tabla.dataSource = self
    }

    @IBAction func atras(_ sender: UIBarButtonItem) {
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
