//
//  DetailViewController.swift
//  Wallet
//
//  Created by Estia on 08/07/16.
//  Copyright © 2016 AleMarco. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var contoDetail: ContoCorrente!
    var nome: String!
    
    @IBOutlet weak var nomeContoLabel: UILabel!
    @IBOutlet weak var importoContoLabel: UILabel!
    @IBOutlet weak var nomeTipoContoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Dettaglio"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(ViewController.launchAlert))
        // Do any additional setup after loading the view.
        nomeContoLabel.text = contoDetail.nome!
        importoContoLabel.text = String(contoDetail.importo!)
        nomeTipoContoLabel.text = contoDetail.tipoConto?.nome
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
