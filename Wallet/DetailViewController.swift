//
//  DetailViewController.swift
//  Wallet
//
//  Created by Estia on 08/07/16.
//  Copyright © 2016 AleMarco. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var contoDetail: ContoCorrente? = nil
    var nome: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Dettaglio"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(ViewController.launchAlert))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
